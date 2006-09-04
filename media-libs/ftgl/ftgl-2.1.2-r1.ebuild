# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ftgl/ftgl-2.1.2-r1.ebuild,v 1.6 2006/09/04 20:01:38 vapier Exp $

inherit eutils flag-o-matic libtool

DESCRIPTION="library to use arbitrary fonts in OpenGL applications"
HOMEPAGE="http://homepages.paradise.net.nz/henryj/code/#FTGL"
SRC_URI="http://opengl.geek.nz/ftgl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"
IUSE=""

DEPEND=">=media-libs/freetype-2.0.9
	virtual/opengl
	virtual/glut"

S=${WORKDIR}/FTGL/unix

src_unpack() {
	unpack ${A}

	# Use the correct includedir for pkg-config
	epatch \
		"${FILESDIR}"/${PV}-ftgl.pc.in.patch \
		"${FILESDIR}"/${P}-gcc41.patch
	if ! has_version app-doc/doxygen ; then
		cd FTGL/docs
		tar xzf html.tar.gz || die "unpack html.tar.gz"
		ln -fs ../../docs/html "${S}/docs"
	fi
	sed -i \
		-e "s:\((PACKAGE_NAME)\):\1-${PVR}:g" ${S}/docs/Makefile \
		|| die "sed failed"
	sed -i \
		-e "s:    \\$:\t\\$:g" ${S}/src/Makefile \
		|| die "sed failed"

	elibtoolize
}

src_compile() {
	strip-flags # ftgl is sensitive - bug #112820
	econf \
		--enable-shared \
		--enable-shared \
		|| die
	emake || die
}

src_install() {
	einstall || die
	dodoc README.txt
}
