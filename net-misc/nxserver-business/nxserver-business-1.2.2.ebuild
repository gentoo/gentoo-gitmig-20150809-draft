# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header $

inherit nxserver

DEPEND="$DEPEND
	    !net-misc/nxserver-personal
		!net-misc/nxserver-enterprise"

pkg_nofetch ()
{
	nxserver_pkg_nofetch business
}
