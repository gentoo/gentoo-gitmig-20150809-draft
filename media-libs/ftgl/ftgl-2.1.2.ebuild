# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ftgl/ftgl-2.1.2.ebuild,v 1.6 2005/07/13 14:26:23 swegener Exp $

inherit eutils

DESCRIPTION="library to use arbitrary fonts in OpenGL applications"
HOMEPAGE="http://homepages.paradise.net.nz/henryj/code/#FTGL"
SRC_URI="http://opengl.geek.nz/ftgl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

DEPEND=">=media-libs/freetype-2.0.9
	virtual/opengl
	virtual/glut"

S="${WORKDIR}/FTGL/unix"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"

	# Use the correct includedir for pkg-config
	epatch "${FILESDIR}/${PV}-ftgl.pc.in.patch"
	if ! has_version app-doc/doxygen; then
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
}

src_install() {
	einstall || die
	dodoc README.txt
}
