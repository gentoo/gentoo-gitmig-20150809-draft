# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxserver-enterprise/nxserver-enterprise-1.3.2.ebuild,v 1.1 2004/05/13 22:39:26 stuart Exp $

inherit nxserver-1.3.2

DEPEND="$DEPEND
	!net-misc/nxserver-personal
	!net-misc/nxserver-business"

MY_PV="${PV}-25"

SRC_URI="http://www.nomachine.com/download/nxserver-enterprise/${PV}/RedHat-9.0/nxserver-${MY_PV}.i386.rpm"
