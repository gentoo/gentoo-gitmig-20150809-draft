# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/genmenu/genmenu-1.0.2.ebuild,v 1.1 2003/05/29 09:59:34 george Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="menu generator for Blackbox, WindowMaker, and Enlightenment"
HOMEPAGE="http://projects.gtk.mine.nu/genmenu"
SRC_URI="http://projects.gtk.mine.nu/archive/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="virtual/glibc"
RDEPEND="app-shells/bash"

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
