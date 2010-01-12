# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/g3data/g3data-1.5.3.ebuild,v 1.2 2010/01/12 15:47:58 fauli Exp $

EAPI=2
inherit eutils

DESCRIPTION="Tool for extracting data from graphs"
HOMEPAGE="http://www.frantz.fi/software/g3data.php"
SRC_URI="http://www.frantz.fi/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="examples"

RDEPEND=">=x11-libs/gtk+-2.6.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	~app-text/docbook-sgml-utils-0.6.14"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_install() {
	dobin g3data || die "dobin failed - no binary!"
	doman g3data.1 || die "doman failed"
	dodoc README.SOURCE
	# xpm image is really a png file
	newicon g3data-icon.xpm g3data.png
	make_desktop_entry g3data "g3data data extractor"
	if use examples; then
		docinto examples
		dodoc README.TEST
		insinto /usr/share/doc/${PF}/examples
		doins test1.png test1.values test2.png test2.values
	fi
}
