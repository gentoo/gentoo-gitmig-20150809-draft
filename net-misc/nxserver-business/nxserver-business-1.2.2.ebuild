# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxserver-business/nxserver-business-1.2.2.ebuild,v 1.4 2004/03/10 22:07:41 stuart Exp $

MY_PV="${PV}-72"

inherit nxserver

DEPEND="$DEPEND
	!net-misc/nxserver-personal
	!net-misc/nxserver-enterprise
	=net-misc/nxssh-1.2.2
	=net-misc/nxproxy-1.2.2"

RESTRICT="$RESTRICT fetch"

pkg_nofetch ()
{
	nxserver_pkg_nofetch business
}
