#!/bin/bash
docker --debug build --file "${pwd}\docker\Dockerfile" --tag "custom" "${pwd}"