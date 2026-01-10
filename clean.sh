docker compose down -v
docker ps -q | xargs docker rm
docker images -q | xargs docker image rm
docker system prune
rm -rf volumes/mariadb volumes/wordpress && mkdir -p volumes/mariadb volumes/wordpress