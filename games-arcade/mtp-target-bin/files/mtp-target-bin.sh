#!/bin/bash

cd /opt/mtp-target-bin

exe=""
dir=""
case $0 in
	*client*) exe=client; dir=client;;
	*server*) exe=mtp_target_service; dir=server;;
	*) exit 1;;
esac

cd ${dir}
export LD_LIBRARY_PATH="../lib:${LD_LIBRARY_PATH}"
exec ./${exe} "$@"
