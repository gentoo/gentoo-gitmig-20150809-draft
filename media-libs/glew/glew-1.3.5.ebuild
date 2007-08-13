# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glew/glew-1.3.5.ebuild,v 1.6 2007/08/13 20:59:57 dertobi123 Exp $

inherit eutils multilib toolchain-funcs

DESCRIPTION="The OpenGL Extension Wrangler Library"
HOMEPAGE="http://glew.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tgz"

LICENSE="BSD GLX SGI-B GPL-2"

IUSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ia64 ppc ~ppc64 ~sparc x86"

RDEPEND="virtual/opengl
	virtual/glu"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Portage will strip binaries if needed
	# If we strip here, static library will have no symbols
	sed -i \
		-e "s/-s\b//g" \
		Makefile || die "sed failed"
}

src_compile(){
	# Add system's CFLAGS
	sed -i "s/OPT = \$(POPT)/OPT = ${CFLAGS}/" Makefile
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	emake GLEW_DEST="${D}/usr" LIBDIR="${D}/usr/$(get_libdir)" install || die "Install failed!"

	dodoc README.txt ChangeLog
	cd "${S}/doc"
	dohtml *.{html,css,png,jpg} || die "Documentation install failed"
	dodoc *.txt || die "Documentation install failed"
}
