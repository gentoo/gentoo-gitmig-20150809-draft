# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/i3lock/i3lock-2.2.ebuild,v 1.1 2011/11/07 19:23:44 xarthisius Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Simple screen locker"
HOMEPAGE="http://i3wm.org/i3lock/"
SRC_URI="http://i3wm.org/${PN}/${P}.tar.bz2"

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
DOC=( README )

pkg_setup() {
	tc-export CC
}

src_prepare() {
	sed -i -e 's:login:system-auth:' ${PN}.pam || die
}

src_configure() {
	use cairo || export NOLIBCAIRO=1
}

src_install() {
	default
	doman ${PN}.1
}
