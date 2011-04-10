# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/gsim/gsim-0.19.1.ebuild,v 1.3 2011/04/10 07:12:58 tove Exp $

EAPI="3"

inherit eutils qt4-r2

DESCRIPTION="Programm for visualisation and processing of experimental and simulated NMR spectra"
HOMEPAGE="http://sourceforge.net/projects/gsim"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="emf opengl"

RDEPEND="
	x11-libs/qt-svg:4
	dev-cpp/muParser
	sci-libs/libcmatrix
	virtual/blas
	media-libs/freetype
	emf? ( media-libs/libemf )
	opengl? ( x11-libs/qt-opengl:4 )"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${PV}-build.conf.patch )
DOCS="release.txt README_GSIM.* quickstart.* changes.log programming.*"

src_prepare() {
	edos2unix ${PN}.pro

	qt4-r2_src_prepare

	cat >> build.conf <<- EOF
	INCLUDEPATH += \"${EPREFIX}/usr/include/libcmatrixR3/\" \
		\"${EPREFIX}/usr/include/Minuit2\" \
		\"${EPREFIX}/usr/include\"
	LIBS += -lcmatrix  -lMinuit2 -lmuparser $(pkg-config --libs cblas)
	EOF
	use opengl && echo "CONFIG+=use_opengl" >> build.conf
	if use emf; then
	cat >> build.conf <<- EOF
	CONFIG+=use_emf
	DEFINES+=USE_EMF_OUTPUT
	LIBS += -L\"${EPREFIX}/usr/include/libEMF\" -lEMF
	EOF
	fi
	sed \
		-e "s:quickstart.pdf:../share/doc/${PF}/quickstart.pdf:g" \
		-e "s:README_GSIM.pdf:../share/doc/${PF}/README_GSIM.pdf:g" \
		-i mainform.h || die
}

src_install() {
	qt4-r2_src_install
	dobin ${PN} || die "no ${PN}"
	insinto /usr/share/${PN}
	doins -r images ${PN}.ico || die "no images"
	insinto /usr/share/${PN}/ui
	doins *.ui || die
}
