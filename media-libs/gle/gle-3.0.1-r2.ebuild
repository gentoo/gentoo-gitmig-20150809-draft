# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gle/gle-3.0.1-r2.ebuild,v 1.24 2004/11/05 22:11:40 corsair Exp $

IUSE=""

inherit gnuconfig

DESCRIPTION="GL extrusion library"
SRC_URI="http://www.linas.org/gle/pub/gle-3.0.1.tar.gz"
HOMEPAGE="http://www.linas.org/gle"

SLOT="0"
LICENSE="Artistic GPL-2"
KEYWORDS="x86 ppc sparc alpha amd64 ia64 hppa ~ppc64"

DEPEND="virtual/opengl
	virtual/glu
	virtual/glut"

src_unpack() {
	unpack ${A}

	cd ${S}
	gnuconfig_update
}

src_compile() {
	econf --with-x || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README
	dohtml -r public_html
}
