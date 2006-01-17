# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/phex/files/phex-2.8.2.92.sh,v 1.1 2006/01/17 21:14:40 sekretarz Exp $

#!/bin/sh

java -classpath $(java-config -p commons-logging,commons-httpclient-3,phex,jgoodies-looks-1.3,jgoodies-forms) phex.Main
