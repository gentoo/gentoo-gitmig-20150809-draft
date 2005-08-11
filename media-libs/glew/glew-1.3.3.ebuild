# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glew/glew-1.3.3.ebuild,v 1.4 2005/08/11 09:51:42 r3pek Exp $

DESCRIPTION="The OpenGL Extension Wrangler Library"
HOMEPAGE="http://glew.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tgz"

LICENSE="BSD GLX SGI-B GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RDEPEND="virtual/opengl
	virtual/x11
	virtual/glu"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_compile(){
	# Add system's CFLAGS and compile
	cd ${S}
	sed -i "s/OPT = \$(POPT)/OPT = ${CFLAGS}/" Makefile
	emake -j1 || die "emake failed"
}

src_install() {
	make GLEW_DEST="${D}/usr" install || die "Install failed!"

	dodoc README.txt ChangeLog
	cd ${S}/doc
	dohtml *.{html,css,png,jpg} || die "Documentation install failed"
	dodoc *.txt || die "Documentation install failed"
}
