# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/jpegoptim/jpegoptim-1.2.3.ebuild,v 1.3 2010/11/08 22:45:08 maekke Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="JPEG file optimiser"
HOMEPAGE="http://www.kokkonen.net/tjko/projects.html"
SRC_URI="http://www.kokkonen.net/tjko/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND="virtual/jpeg"

src_prepare() {
	epatch "${FILESDIR}"/${P}-parallel_make.patch
}

src_configure() {
	tc-export CC
	econf
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die
	dodoc README
}
