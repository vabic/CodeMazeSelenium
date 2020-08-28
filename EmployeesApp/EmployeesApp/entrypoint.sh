#!/bin/bash

set -e
run_cmd="dotnet run --no-launch-profile --no-restore --no-build"
exec $run_cmd