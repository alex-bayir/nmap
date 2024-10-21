@echo off
chcp 65001
@echo on
docker --debug build --file "%CD%\docker\Dockerfile" --tag "custom" "%CD%"