#!/bin/bash
# $Header: /var/cvsroot/gentoo-x86/net-www/orion/files/2.0.1/stop_orion.sh,v 1.1 2003/05/01 17:50:29 absinthe Exp $
ps auxww | grep orion.jar | awk '{print $2}' | xargs kill &> /dev/null
