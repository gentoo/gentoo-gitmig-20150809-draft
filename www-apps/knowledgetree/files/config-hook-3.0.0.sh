#!/bin/bash
# Sets installation directory and hostname when installing knowledgeTree

if [ $1 = "install" ]; then
    cd ${MY_INSTALLDIR}/config
    sed -i -e "s#rootUrl = default#rootUrl = \"${VHOST_APPDIR}\"#" config.ini
fi
