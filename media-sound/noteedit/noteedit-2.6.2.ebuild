# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/noteedit/noteedit-2.6.2.ebuild,v 1.7 2005/01/14 23:57:13 danarmak Exp $

IUSE=""

inherit kde-functions kde eutils flag-o-matic

DESCRIPTION="Musical score editor (for Linux)."
HOMEPAGE="http://rnvs.informatik.tu-chemnitz.de/~jan/noteedit/"
SRC_URI="http://rnvs.informatik.tu-chemnitz.de/cgi-bin/nph-sendbin.cgi/~jan/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc amd64"

DEPEND="|| ( kde-base/kdemultimedia-meta kde-base/kdemultimedia )
	kde-base/arts
	media-libs/tse3"

need-kde 3

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc34.patch
}

src_compile() {
	kde_src_compile myconf configure || die
	append-flags -fpermissive
	emake -j1 || die
}

src_install() {
	kde_src_install
	dodoc FAQ FAQ.de INSTALL INSTALL.de examples
	docinto examples
	dodoc noteedit/examples/*
}
