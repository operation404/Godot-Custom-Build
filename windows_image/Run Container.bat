cd D:\Projects and Repositories\Godot Building\custom-build\windows_image
:: --rm removes the container after running, these are one and done containers
docker compose run --rm winbuilder
:: Keep the command prompt open and interactive
 cmd /k