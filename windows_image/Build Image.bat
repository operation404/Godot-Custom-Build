cd D:\Projects and Repositories\Godot Building\custom-build\windows_image
docker compose build
:: Remove previous and now outdated versions of the image
docker container prune -f
docker image prune -f
:: Keep the command prompt open and interactive
 cmd /k