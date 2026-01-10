#!/bin/sh

set -e

# 1. ログ用と実行用のディレクトリ作成
if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ ! -d "/var/log/mysql" ]; then
	mkdir -p /var/log/mysql
	chown -R mysql:mysql /var/log/mysql
fi

# 2. データベースの初期化 (初回のみ実行)
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initialising database..."
    chown -R mysql:mysql /var/lib/mysql

    # 設定ファイルを隠さずに初期化
    # --datadir は設定ファイルにも書いてあるが、念のため引数でも渡してOK
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db
    
    if [ $? -ne 0 ]; then
        echo "Install failed!"
        exit 1
    fi

    cat << EOF > /tmp/init_db.sql
USE mysql;
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';
FLUSH PRIVILEGES;
EOF

    # ブートストラップ実行（ネットワークなしでSQL実行）
    /usr/bin/mysqld --user=mysql --bootstrap < /tmp/init_db.sql
    rm -f /tmp/init_db.sql
fi

# 3. 本番起動
# execをつけることでPID 1にする
exec /usr/bin/mysqld --user=mysql --console
