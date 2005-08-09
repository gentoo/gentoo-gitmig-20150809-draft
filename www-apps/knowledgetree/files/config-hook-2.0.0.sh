#!/bin/bash
# Sets installation directory and hostname when installing knowledgeTree

if [ "x$1"=="xinstall" ]; then
    cd ${MY_INSTALLDIR}/config
    sed -i -e "s#default->rootUrl  = \"\"#default->rootUrl  = \"${VHOST_APPDIR}\"#" environment.php
fi
