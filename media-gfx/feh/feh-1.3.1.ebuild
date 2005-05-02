# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/feh/feh-1.3.1.ebuild,v 1.1 2005/05/02 10:03:09 lu_zero Exp $

DESCRIPTION="A fast, lightweight imageviewer using imlib2"
HOMEPAGE="http://www.linuxbrit.co.uk/feh"
SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ppc64 ~alpha"
IUSE=""

DEPEND=">=media-libs/giblib-1.2.4
	>=media-libs/imlib2-1.0.0
	>=media-libs/jpeg-6b-r4
	media-libs/libpng
	virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "/^docsdir =/s:doc/feh:share/doc/${PF}:" Makefile.in
}

src_install() {
	make install DESTDIR="${D}" || die
	prepalldocs
}
