# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/krusader/krusader-1.40_beta1-r1.ebuild,v 1.4 2004/07/01 11:58:30 agriffis Exp $

inherit kde eutils flag-o-matic

MY_P=${P/_/"-"}
S=${WORKDIR}/${MY_P}

DESCRIPTION="An advanced twin-panel (commander-style) file-manager for KDE 3.x with many extras"
HOMEPAGE="http://krusader.sourceforge.net/"
SRC_URI="mirror://sourceforge/krusader/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""

need-kde 3

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
