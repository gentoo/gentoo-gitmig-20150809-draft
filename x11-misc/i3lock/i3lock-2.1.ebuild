# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/i3lock/i3lock-2.1.ebuild,v 1.1 2011/07/22 09:41:18 xarthisius Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Simple screen locker"
HOMEPAGE="http://i3wm.org/i3lock/"
SRC_URI="http://i3wm.org/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+cairo"

RDEPEND="virtual/pam
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-image
	cairo? ( x11-libs/cairo[xcb] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	tc-export CC
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
	sed -i -e 's:login:system-auth:' ${PN}.pam || die
}

src_configure() {
	use cairo || export NOLIBCAIRO=1
}
