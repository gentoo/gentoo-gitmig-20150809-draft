# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/bullet/bullet-2.75.ebuild,v 1.2 2009/11/23 02:07:42 bicatali Exp $

EAPI=2
inherit eutils cmake-utils

DESCRIPTION="Continuous Collision Detection and Physics Library"
HOMEPAGE="http://www.bulletphysics.com/"
SRC_URI="http://bullet.googlecode.com/files/${P}.tgz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND="virtual/glut"
DEPEND="${RDEPEND}"

src_prepare() {
	rm -f Extras/CDTestFramework/AntTweakBar/lib/libAntTweakBar.so
	sed -i \
		-e 's:DESTINATION lib:DESTINATION lib${LIB_SUFFIX}:g' \
		src/*/CMakeLists.txt || die
}

src_configure() {
	mycmakeargs="
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_DEMOS=OFF
		-DBUILD_EXTRAS=OFF"
	cmake-utils_src_configure
	sed -e "s|@prefix@|${ROOT}usr|" \
		-e 's|@exec_prefix@|${prefix}|' \
		-e "s|@libdir@|\${exec_prefix}/$(get_libdir)|" \
		-e "s|@PACKAGE_VERSION@|${PV}|" \
		-e 's|Libs:.*$|Libs:-L${libdir} -lBulletDynamics -lBulletCollision -lLinearMath -lBulletSoftBody|' \
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
