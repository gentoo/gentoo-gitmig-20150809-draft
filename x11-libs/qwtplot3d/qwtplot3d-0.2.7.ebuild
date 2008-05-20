# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qwtplot3d/qwtplot3d-0.2.7.ebuild,v 1.3 2008/05/20 18:54:17 bicatali Exp $

EAPI=1
inherit multilib qt4

DESCRIPTION="Qt4/OpenGL-based 3D widget library for C++"
HOMEPAGE="http://qwtplot3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="ZLIB"
SLOT="0"
IUSE="doc examples"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

RDEPEND="|| ( >=x11-libs/qt-4:4
			  ( x11-libs/qt-gui:4 x11-libs/qt-opengl:4 ) )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

QT4_BUILT_WITH_USE_CHECK="opengl"

S="${WORKDIR}/${PN}"

src_unpack () {
	unpack ${A}
	epatch "${FILESDIR}"/${PN}-profile.patch
	epatch "${FILESDIR}"/${PN}-examples.patch
	epatch "${FILESDIR}"/${PN}-doxygen.patch
}

src_compile () {
	echo >> ${PN}.pro "target.path = /usr/$(get_libdir)"
	echo >> ${PN}.pro "headers.path = /usr/include/${PN}"
	echo >> ${PN}.pro "headers.files = \$\$HEADERS"
	echo >> ${PN}.pro "INSTALLS = target headers"

	eqmake4 ${PN}.pro || die "eqmake4 failed"
	emake || die "emake failed"
	 if use doc ; then
		 cd doc
		 doxygen Doxyfile.doxygen || die "doxygen failed"
	 fi
}

src_install () {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die "doins examples failed"
	fi
	use doc && dohtml -r doc/web/doxygen/*
}
