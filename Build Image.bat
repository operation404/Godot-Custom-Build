cd D:\Projects and Repositories\Godot Building\custom-build
docker compose build
:: Remove previous and now outdated versions of the image
docker image prune -y