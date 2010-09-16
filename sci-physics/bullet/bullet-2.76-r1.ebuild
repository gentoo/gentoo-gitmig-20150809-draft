# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/bullet/bullet-2.76-r1.ebuild,v 1.4 2010/09/16 17:31:03 scarabeus Exp $

EAPI=2
inherit eutils cmake-utils

DESCRIPTION="Continuous Collision Detection and Physics Library"
HOMEPAGE="http://www.bulletphysics.com/"
SRC_URI="http://bullet.googlecode.com/files/${P}.tgz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc examples"

RDEPEND="media-libs/freeglut"
DEPEND="${RDEPEND}"

src_configure() {
	mycmakeargs="
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_DEMOS=OFF
		-DBUILD_EXTRAS=OFF
		-DINSTALL_LIBS=ON
		-DINSTALL_EXTRA_LIBS=ON"
	#	-DCMAKE_INSTALL_PREFIX=/usr"

	cmake-utils_src_configure
	sed -e "s|@prefix@|${ROOT}usr|" \
		-e 's|@exec_prefix@|${prefix}|' \
		-e "s|@libdir@|\${exec_prefix}/$(get_libdir)|" \
		-e "s|@PACKAGE_VERSION@|${PV}|" \
		-e "s|@includedir@|\${prefix}/include|" \
		bullet.pc.in > bullet.pc || die
}

src_install() {
	cmake-utils_src_install
	insinto /usr/$(get_libdir)/pkgconfig
	doins bullet.pc || die
	dodoc README ChangeLog AUTHORS
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins *.pdf || die
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r Extras Demos || die
	fi
}
