# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/vntex/vntex-20030303.ebuild,v 1.4 2004/06/25 02:17:48 agriffis Exp $

DESCRIPTION="Vietnamese support for TeX"
HOMEPAGE="http://vntex.sourceforge.net/"
SRC_URI="mirror://sourceforge/vntex/${P}.tar.gz"
LICENSE="freedist"

KEYWORDS="x86 ~sparc"
SLOT="0"
IUSE=""

DEPEND="virtual/tetex"
S=${WORKDIR}

src_install () {

	TT=`kpsewhich -expand-var '\$TEXMFMAIN'`
	dodir ${TT}
	cp -R ${S}/* ${D}/${TT}
}

pkg_postinst() {

	[ -e /usr/bin/mktexlsr ] && /usr/bin/mktexlsr

}

pkg_postrm() {

	[ -e /usr/bin/mktexlsr ] && /usr/bin/mktexlsr

}
