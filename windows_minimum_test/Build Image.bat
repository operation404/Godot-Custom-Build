docker compose build
:: Remove previous and now outdated versions of the image
docker container prune -f
docker image prune -f
:: Keep the command prompt open and interactive in case of build errors
 cmd /k