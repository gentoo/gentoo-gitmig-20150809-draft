#!/bin/bash
# $Header: /var/cvsroot/gentoo-x86/net-www/orion/files/2.0/stop_orion.sh,v 1.1 2003/03/22 03:28:35 absinthe Exp $
ps auxww | grep orion.jar | awk '{print $2}' | xargs kill &> /dev/null
