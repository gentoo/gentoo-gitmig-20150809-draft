# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/yacas/yacas-1.0.57.ebuild,v 1.1 2005/01/14 17:05:53 phosphan Exp $

inherit eutils

IUSE="glut"

DESCRIPTION="very powerful general purpose Computer Algebra System"
HOMEPAGE="http://yacas.sourceforge.net/"
SRC_URI="http://${PN}.sourceforge.net/backups/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND="virtual/libc
	>=sys-apps/sed-4
	glut? ( media-libs/glut )"


src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}.patch
	if ! use glut; then
		sed -e 's:opengl::g' -i plugins/Makefile.in || die "sed (opengl) failed"
		sed -e 's/\(^PLUGINDOCSCHAPTERS.*\)opengl.chapt\(.*\)/\1 \2/' -i \
		manmake/Makefile.in || die 'sed (manmake) failed'
	fi
}

src_compile() {
	econf --with-numlib=native || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR="${D}" install-strip || die

	dodoc AUTHORS INSTALL NEWS README TODO
	mv ${D}/usr/share/${PN}/documentation ${D}/usr/share/doc/${PF}/html
	rmdir ${D}/usr/include/
	rm ${D}/usr/share/${PN}/include/win32*
}
