# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/passivetex/passivetex-1.25.ebuild,v 1.1 2004/02/02 15:42:46 usata Exp $

inherit latex-package

S=${WORKDIR}/${PN}
DESCRIPTION="A namespace-aware XML parser written in Tex"
# Taken from: http://www.tei-c.org.uk/Software/passivetex/${PN}.zip
SRC_URI="mirror://gentoo/${P}.zip"
HOMEPAGE="http://www.tei-c.org.uk/Software/passivetex/"
LICENSE="freedist"

KEYWORDS="~x86 ~sparc"
SLOT="0"
IUSE=""

RDEPEND="virtual/tetex
	>=dev-tex/xmltex-1.9"

DEPEND="${RDEPEND}
	app-arch/unzip"

src_install() {

	insinto ${TEXMF}/tex/passivetex
	doins *.sty *.xmt

	dodoc README.passivetex LICENSE index.xml
	dohtml index.html
}
