# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/keyjnote/keyjnote-0.10.1.ebuild,v 1.1 2007/09/10 08:49:17 lu_zero Exp $

DESCRIPTION="Pdf viewer and presentation program"
HOMEPAGE="http://keyjnote.sf.net"
SRC_URI="mirror://sourceforge/${PN}/KeyJnote-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

S="${WORKDIR}/KeyJnote-${PV}"

DEPEND=">=dev-lang/python-2.3
		dev-python/pyopengl
		dev-python/pygame
		dev-python/imaging
		|| ( app-text/poppler virtual/ghostscript )
		app-text/pdftk"

src_install() {
	cp keyjnote.py keyjnote
	dobin keyjnote
	dodoc demo.pdf keyjnote.html
}
