# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/g3data/g3data-1.5.1.ebuild,v 1.5 2012/05/04 08:06:59 jdhore Exp $

EAPI="1"
inherit eutils

DESCRIPTION="Tool for extracting data from graphs"
HOMEPAGE="http://www.frantz.fi/software/g3data.php"
SRC_URI="http://www.frantz.fi/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="examples"

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	~app-text/docbook-sgml-utils-0.6.14"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin g3data || die "dobin failed - no binary!"
	doman g3data.1.gz || die "doman failed"
	dodoc README.SOURCE || die "README.SOURCE not found"
	if use examples; then
		docinto examples
		dodoc README.TEST
		insinto /usr/share/doc/${PF}/examples
		doins test1.png test1.values test2.png test2.values
	fi
}
