# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/noteedit/noteedit-2.6.2.ebuild,v 1.9 2006/05/31 11:10:10 flameeyes Exp $

IUSE=""

ARTS_REQUIRED="yes"
inherit kde-functions kde eutils flag-o-matic

DESCRIPTION="Musical score editor (for Linux)."
HOMEPAGE="http://rnvs.informatik.tu-chemnitz.de/~jan/noteedit/"
SRC_URI="http://rnvs.informatik.tu-chemnitz.de/cgi-bin/nph-sendbin.cgi/~jan/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc amd64"

DEPEND="|| ( kde-base/kdemultimedia-meta kde-base/kdemultimedia )
	media-libs/tse3"

need-kde 3

PATCHES="${FILESDIR}/${P}-gcc34.patch"

src_compile() {
	kde_src_compile myconf configure || die
	append-flags -fpermissive
	emake -j1 || die
}

src_install() {
	kde_src_install
	dodoc FAQ FAQ.de examples
	docinto examples
	dodoc noteedit/examples/*
}
