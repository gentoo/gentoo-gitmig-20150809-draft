# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/keyjnote/keyjnote-0.10.2.ebuild,v 1.2 2009/03/30 13:49:40 loki_val Exp $

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
		|| ( virtual/poppler-utils virtual/ghostscript )
		app-text/pdftk"

src_install() {
	newbin keyjnote.py keyjnote || die
	dodoc demo.pdf keyjnote.html || die
}
