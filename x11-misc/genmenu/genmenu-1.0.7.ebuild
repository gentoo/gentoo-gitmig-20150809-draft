# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/genmenu/genmenu-1.0.7.ebuild,v 1.1 2004/08/18 10:03:42 lanius Exp $

inherit eutils

IUSE=""

DESCRIPTION="menu generator for *box, WindowMaker, and Enlightenment"
HOMEPAGE="http://gtk.no/genmenu"
SRC_URI="http://gtk.no/archive/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}
	app-shells/bash"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/genmenu-1.0.2.patch
}

src_install () {
	dobin genmenu

	# Install documentation.
	dodoc ChangeLog README
}
