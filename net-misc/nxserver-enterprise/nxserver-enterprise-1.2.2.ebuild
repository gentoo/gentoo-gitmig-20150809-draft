# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxserver-enterprise/nxserver-enterprise-1.2.2.ebuild,v 1.3 2003/09/10 17:22:15 stuart Exp $

MY_PV="${PV}-72"

inherit nxserver

DEPEND="$DEPEND
	!net-misc/nxserver-business
	!net-misc/nxserver-personal
	=net-misc/nxssh-1.2.2
	=net-misc/nxproxy-1.2.2"

RESTRICT="$RESTRICT fetch"

pkg_nofetch ()
{
	nxserver_pkg_nofetch personal
}
