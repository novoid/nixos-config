#!/usr/bin/env bash
nix flake update && \
	git add flake.lock && \
	git commit -m 'updated flake.lock via update-flake.sh' && \
	echo "finished without error."
#end
