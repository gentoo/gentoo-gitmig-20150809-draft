# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim-cvs/gaim-cvs-0.60-r4.ebuild,v 1.4 2003/09/05 23:58:58 msterret Exp $

IUSE="nls perl spell"

DESCRIPTION="GTK Instant Messenger client - CVS ebuild."
HOMEPAGE="http://gaim.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

DEPEND="!net-im/gaim"

src_unpack() {
	eerror "Gaim-cvs has been depreciated at the request of the gaim developers"
	eerror "and the system administrators at sourceforge."
	echo
	eerror "GAIM is back on a regular release schedule, so please"
	eerror "emerge unmerge gaim-cvs; emerge gaim"
	die Package Removed From Portage
}
