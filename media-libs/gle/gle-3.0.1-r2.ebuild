# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gle/gle-3.0.1-r2.ebuild,v 1.17 2003/09/11 01:17:46 msterret Exp $

inherit gnuconfig

S=${WORKDIR}/${P}
DESCRIPTION="GL extrusion library"
SRC_URI="http://www.linas.org/gle/pub/gle-3.0.1.tar.gz"
HOMEPAGE="http://www.linas.org/gle"

DEPEND="virtual/opengl
	virtual/glu
	virtual/glut"

SLOT="0"
LICENSE="Artistic GPL-2"
KEYWORDS="x86 ppc sparc alpha amd64"

src_compile() {
	gnuconfig_update
	econf --with-x || die
	emake || die
}

src_install() {

	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README
	dohtml -r public_html
}
