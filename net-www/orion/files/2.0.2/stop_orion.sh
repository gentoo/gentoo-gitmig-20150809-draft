#!/bin/bash
# $Header: /var/cvsroot/gentoo-x86/net-www/orion/files/2.0.2/stop_orion.sh,v 1.1 2004/07/16 14:00:35 axxo Exp $
ps auxww | grep orion.jar | awk '{print $2}' | xargs kill &> /dev/null
