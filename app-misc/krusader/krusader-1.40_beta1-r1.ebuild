# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/krusader/krusader-1.40_beta1-r1.ebuild,v 1.1 2004/06/22 20:22:08 absinthe Exp $

IUSE=""

inherit kde
need-kde 3

MY_P=${P/_/"-"}
S=${WORKDIR}/${MY_P}

DESCRIPTION="An advanced twin-panel (commander-style) file-manager for KDE 3.x with many extras"
HOMEPAGE="http://krusader.sourceforge.net/"
SRC_URI="mirror://sourceforge/krusader/${MY_P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc34-goodness.diff
}

src_compile() {
	cd ${S}

	if [ ${ARCH} = "amd64" ] ; then
		append-flags -fPIC
	fi

	kde_src_compile configure make
}
