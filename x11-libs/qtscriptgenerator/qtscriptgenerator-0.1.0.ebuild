# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qtscriptgenerator/qtscriptgenerator-0.1.0.ebuild,v 1.13 2011/03/26 16:46:57 dilfridge Exp $

EAPI="2"

MY_PN="${PN}-src"
MY_P="${MY_PN}-${PV}"

inherit multilib qt4

DESCRIPTION="Tool for generating Qt bindings for Qt Script"
HOMEPAGE="http://code.google.com/p/qtscriptgenerator/"
SRC_URI="http://qtscriptgenerator.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="debug kde"

DEPEND="
	x11-libs/qt-dbus:4
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	!kde? ( || (
		x11-libs/qt-phonon:4
		media-libs/phonon
	) )
	kde? ( media-libs/phonon )
	x11-libs/qt-script:4
	x11-libs/qt-sql:4
	x11-libs/qt-svg:4
	x11-libs/qt-webkit:4
	x11-libs/qt-xmlpatterns:4
"
RDEPEND="${DEPEND}"

PLUGINS="core gui network opengl sql svg uitools webkit xml xmlpatterns"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# remove phonon
	sed -i "/typesystem_phonon.xml/d" generator/generator.qrc || die "sed failed"
	sed -i "/qtscript_phonon/d" qtbindings/qtbindings.pro || die "sed failed"

	# Fix for GCC-4.4, bug 268086
	epatch "${FILESDIR}/${PN}-gcc44.patch"
	qt4_src_prepare
}

src_configure() {
	cd "${S}"/generator
	eqmake4 generator.pro
	cd "${S}"/qtbindings
	eqmake4 qtbindings.pro
}

src_compile() {
	# use only one job for compilation wrt bug 274458
	cd "${S}"/generator
	emake -j1 || die "make generator failed"
	./generator --include-paths="/usr/include/qt4/" || die "running generator failed"

	cd "${S}"/qtbindings
	emake -j1 || die "make qtbindings failed"
}

src_install() {
	insinto /usr/$(get_libdir)/qt4/plugins/script/
	insopts -m0755
	doins -r "${S}"/plugins/script/*.so || die "doins failed"
}
