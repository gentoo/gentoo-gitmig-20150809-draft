# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim-cvs/gaim-cvs-0.60-r4.ebuild,v 1.2 2003/04/06 13:24:11 sethbc Exp $

IUSE="nls perl spell"

DESCRIPTION="GTK Instant Messenger client - CVS ebuild."
HOMEPAGE="http://gaim.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

DEPEND="!net-im/gaim"

src_unpack() {
	eerror "Gaim-cvs has been deprecated at the request of the gaim develoeprs"
	eerror "and the system administrators at sourceforge"	
	eerror "GAIM is back on a regular release schedule, so please"
	eerror "emerge unmerge gaim-cvs; emerge gaim"
	die
}
