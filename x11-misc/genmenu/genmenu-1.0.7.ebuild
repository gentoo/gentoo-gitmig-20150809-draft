# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/genmenu/genmenu-1.0.7.ebuild,v 1.3 2004/09/02 22:49:40 pvdabeel Exp $

inherit eutils

DESCRIPTION="menu generator for *box, WindowMaker, and Enlightenment"
HOMEPAGE="http://gtk.no/genmenu"
SRC_URI="http://gtk.no/archive/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="${DEPEND}
	app-shells/bash"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/genmenu-1.0.2.patch"
}

src_install() {
	dobin genmenu || die "dobin failed"
	dodoc ChangeLog README
}
