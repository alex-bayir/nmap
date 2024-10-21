@echo off
chcp 65001
@echo on
docker start "1-dev" || docker run --name "1-dev" -v .\shared:/shared:shared custom:latest || docker rm 1-dev
REM timeout 10 && docker rm 1-dev