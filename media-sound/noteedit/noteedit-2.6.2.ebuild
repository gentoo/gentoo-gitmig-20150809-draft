# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/noteedit/noteedit-2.6.2.ebuild,v 1.1 2004/06/19 04:17:11 squinky86 Exp $

inherit kde-functions kde

DESCRIPTION="Musical score editor (for Linux)."
HOMEPAGE="http://rnvs.informatik.tu-chemnitz.de/~jan/noteedit/"
SRC_URI="http://rnvs.informatik.tu-chemnitz.de/cgi-bin/nph-sendbin.cgi/~jan/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="arts"

DEPEND="arts? ( kde-base/kdemultimedia )
	media-libs/tse3"

need-kde 3


src_install() {
	kde_src_install
	dodoc FAQ FAQ.de INSTALL INSTALL.de examples
	docinto examples
	dodoc noteedit/examples/*
}
