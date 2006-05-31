# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/noteedit/noteedit-2.7.4.ebuild,v 1.4 2006/05/31 11:10:10 flameeyes Exp $

IUSE=""

ARTS_REQUIRED="yes"
inherit kde-functions kde eutils flag-o-matic

DESCRIPTION="Musical score editor (for Linux)."
HOMEPAGE="http://noteedit.berlios.de/"
SRC_URI="http://download.berlios.de/noteedit/noteedit-2.7.4.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~ppc ~x86"

DEPEND="|| ( kde-base/kmid kde-base/kdemultimedia )
	media-libs/tse3"

need-kde 3

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
