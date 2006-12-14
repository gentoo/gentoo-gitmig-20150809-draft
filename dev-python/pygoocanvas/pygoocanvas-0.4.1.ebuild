# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygoocanvas/pygoocanvas-0.4.1.ebuild,v 1.1 2006/12/14 22:29:51 hansmi Exp $

inherit autotools

DESCRIPTION="GooCanvas python bindings"
HOMEPAGE="http://developer.berlios.de/projects/pygoocanvas/"
SRC_URI="http://download.berlios.de/pygoocanvas/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"
IUSE=""

DEPEND="
	>=dev-lang/python-2.1
	x11-libs/goocanvas
"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Works also with an older version of pygobject
	sed -i -e 's#2\.10\.1#2.8.0#' configure.ac || die

	eautoreconf || die
}

src_install() {
	einstall || die
}
