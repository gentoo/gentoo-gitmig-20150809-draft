# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/passivetex/passivetex-1.4-r1.ebuild,v 1.5 2005/01/01 16:29:26 eradicator Exp $

S=${WORKDIR}
DESCRIPTION="A namespace-aware XML parser written in Tex"
SRC_URI="http://www.tei-c.org.uk/Software/passivetex/${PN}.zip"
HOMEPAGE="http://www.tei-c.org.uk/Software/passivetex/"
LICENSE="freedist"

KEYWORDS="x86 ~sparc"
SLOT="0"
IUSE=""

RDEPEND="virtual/tetex
	dev-tex/xmltex"

DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {

	unpack ${A}
	rm -f Makefile
	cp ${FILESDIR}/${P}-Makefile Makefile

}

src_install () {

	make DESTDIR=${D} install || die

}

pkg_postinst() {

	[ -e /usr/bin/mktexlsr ] && /usr/bin/mktexlsr

}

pkg_postrm() {

	[ -e /usr/bin/mktexlsr ] && /usr/bin/mktexlsr

}
