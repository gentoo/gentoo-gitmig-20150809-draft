# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 
# $Header: /var/cvsroot/gentoo-x86/x11-misc/genmenu/genmenu-0.9.0.ebuild,v 1.4 2003/03/11 20:50:08 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="menu generator for Blackbox, WindowMaker, and Enlightenment"
HOMEPAGE="http://projects.gtk.mine.nu/genmenu"
SRC_URI="http://home.online.no/~geir37/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="app-shells/bash"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch genmenu < ${FILESDIR}/${P}.patch
}

src_install () {
	dobin genmenu
	
	# Install documentation.
	dodoc ChangeLog README
}
