# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pqiv/pqiv-0.9.ebuild,v 1.1 2009/05/06 10:32:28 ssuominen Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="Modern rewrite of Quick Image Viewer"
HOMEPAGE="http://www.pberndt.com/Programme/Linux/pqiv"
SRC_URI="http://www.pberndt.com/raw/Programme/Linux/${PN}/_download/${P}.tbz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.8:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	./configure --prefix=/usr --destdir="${D}" || die "./configure failed"
}

src_compile() {
	tc-export CC
	emake || die "emake failed"
}

src_install() {
	emake install || die "emake install failed"
	dodoc README
}
