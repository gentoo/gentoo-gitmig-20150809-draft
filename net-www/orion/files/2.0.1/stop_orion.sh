#!/bin/bash
# $Header: /var/cvsroot/gentoo-x86/net-www/orion/files/2.0.1/stop_orion.sh,v 1.2 2004/07/18 04:26:56 dragonheart Exp $
ps auxww | grep orion.jar | awk '{print $2}' | xargs kill &> /dev/null
