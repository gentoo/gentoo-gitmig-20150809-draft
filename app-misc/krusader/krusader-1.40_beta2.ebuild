# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/krusader/krusader-1.40_beta2.ebuild,v 1.2 2004/07/01 11:58:30 agriffis Exp $

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
	epatch ${FILESDIR}/${P/beta2/beta1}-gcc34-goodness.diff
}

src_compile() {
	cd ${S}

	if [ ${ARCH} = "amd64" ] ; then
		append-flags -fPIC
	fi

	kde_src_compile configure make
}

pkg_postinst() {
	einfo ""
	einfo "Krusader can use some external applications, which includes"
	einfo "- KMail   (kde-base/kdepim)"
	einfo "- Kompare (kde-base/kdesdk)"
	einfo "- KRename (app-misc/krename)"
	einfo "and supports quite a few archive formats. Please use the following"
	einfo "command to install the more uncommon ones in the *nix world:"
	einfo "`emerge app-arch/{arj,unarj,rar,unrar,zip,unzip,unace}`"
	einfo ""
}
