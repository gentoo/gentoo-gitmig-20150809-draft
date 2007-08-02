# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/genmenu/genmenu-1.0.7-r1.ebuild,v 1.2 2007/08/02 12:47:33 uberlord Exp $

inherit eutils

DESCRIPTION="menu generator for *box, WindowMaker, and Enlightenment"
HOMEPAGE="http://gtk.no/genmenu"
SRC_URI="http://gtk.no/archive/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="app-shells/bash"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/genmenu-1.0.2.patch
	epatch "${FILESDIR}"/genmenu-1.0.7-e16.patch
}

src_install() {
	dobin genmenu || die "dobin failed"
	dodoc ChangeLog README
}
