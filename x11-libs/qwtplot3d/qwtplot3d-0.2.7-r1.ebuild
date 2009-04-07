# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qwtplot3d/qwtplot3d-0.2.7-r1.ebuild,v 1.1 2009/04/07 18:51:30 bicatali Exp $

EAPI=2
inherit eutils qt4

DESCRIPTION="Qt4/OpenGL-based 3D widget library for C++"
HOMEPAGE="http://qwtplot3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="ZLIB"
SLOT="0"
IUSE="doc examples"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

RDEPEND="|| ( ( x11-libs/qt-gui:4 x11-libs/qt-opengl:4 )
		<x11-libs/qt-4.4:4[opengl] )
	x11-libs/gl2ps"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-profile.patch
	epatch "${FILESDIR}"/${PN}-examples.patch
	epatch "${FILESDIR}"/${PN}-doxygen.patch
	epatch "${FILESDIR}"/${PN}-sys-gl2ps.patch
	cat >> ${PN}.pro <<-EOF
		target.path = /usr/$(get_libdir)
		headers.path = /usr/include/${PN}
		headers.files = \$\$HEADERS
		INSTALLS = target headers
	EOF
	qt4_src_prepare
}

src_configure() {
	eqmake4
}

src_compile() {
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
	if use doc; then
		insinto /usr/share/doc/${PF}/html
		doins -r doc/web/doxygen/* || die
	fi
}
