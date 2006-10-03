#!/bin/bash
#
progname="skype"
progpath="/opt/${progname}/"
progopts="--resources-path ${progpath}"


#Going to "homedir"
cd ${progpath}
skypecmd="${progpath}${progname}"
exec ${skypecmd} ${progopts} $@
