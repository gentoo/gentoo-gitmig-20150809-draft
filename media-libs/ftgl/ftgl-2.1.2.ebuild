# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ftgl/ftgl-2.1.2.ebuild,v 1.1 2004/12/17 11:29:59 mr_bones_ Exp $

inherit eutils

DESCRIPTION="A free, open source library to enable developers to use arbitrary fonts in their OpenGL applications"
HOMEPAGE="http://homepages.paradise.net.nz/henryj/code/#FTGL"
SRC_URI="http://opengl.geek.nz/ftgl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
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
	if ! has_version doxygen; then
		cd FTGL/docs
		tar xzf html.tar.gz
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
