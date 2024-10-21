#!/bin/bash
docker start "1-dev" || docker run --name "1-dev" -v ./shared:/shared:shared custom:latest || docker rm 1-dev