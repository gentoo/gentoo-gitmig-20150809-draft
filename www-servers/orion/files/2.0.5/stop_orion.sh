#!/bin/bash
# $Header: /var/cvsroot/gentoo-x86/www-servers/orion/files/2.0.5/stop_orion.sh,v 1.1 2005/01/08 01:59:21 karltk Exp $
ps auxww | grep orion.jar | awk '{print $2}' | xargs kill &> /dev/null
