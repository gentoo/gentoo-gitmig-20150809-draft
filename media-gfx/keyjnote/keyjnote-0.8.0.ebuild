# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/keyjnote/keyjnote-0.8.0.ebuild,v 1.1 2006/01/11 06:42:35 lu_zero Exp $

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
		virtual/ghostscript"

src_install() {
	dobin keyjnote.py
	dodoc demo.pdf keyjnote.html
}

