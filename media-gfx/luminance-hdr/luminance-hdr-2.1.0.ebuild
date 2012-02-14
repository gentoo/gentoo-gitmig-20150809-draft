# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/luminance-hdr/luminance-hdr-2.1.0.ebuild,v 1.4 2012/02/14 09:41:29 radhermit Exp $

EAPI="4"

LANGS="cs de es fr it pl ru tr"
inherit qt4-r2 toolchain-funcs

OLD_PN="qtpfsgui"
MY_P="${P/_pre/-pre}"

DESCRIPTION="Luminance HDR is a graphical user interface that provides a workflow for HDR imaging."
HOMEPAGE="http://qtpfsgui.sourceforge.net"
SRC_URI="mirror://sourceforge/${OLD_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug openmp"

DEPEND="
	>=media-gfx/exiv2-0.14
	>=media-libs/libraw-0.13.4
	>=media-libs/openexr-1.2.2-r2
	>=media-libs/tiff-3.8.2-r2
	sci-libs/fftw:3.0
	sci-libs/gsl
	virtual/jpeg
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-sql:4
	x11-libs/qt-webkit:4"
RDEPEND="${DEPEND}"

DOCS="AUTHORS Changelog README TODO"

pkg_setup() {
	if use openmp ; then
		tc-has-openmp || die "Please switch to an openmp compatible compiler"
	fi
}

src_prepare() {
	qt4-r2_src_prepare

	# no insane CXXFLAGS
	sed -i \
		-e '/^QMAKE_CXXFLAGS/d' \
		-e '/^QMAKE_CFLAGS/d' \
		project.pro || die

	if ! use openmp ; then
		sed -i -e '/-fopenmp/d' project.pro || die
	fi

	epatch "${FILESDIR}"/${P}-libraw.patch
}

src_configure() {
	lrelease project.pro || die
	eqmake4 project.pro \
		PREFIX=/usr \
		ENABLE_DEBUG="$(use debug && echo YES || echo NO)" \
		DOCDIR=/usr/share/doc/${PF}
}

src_install() {
	qt4-r2_src_install

	for lang in ${LANGS} ; do
		use linguas_${lang} || { rm "${D}"/usr/share/${PN}/i18n/lang_${lang}.qm || die ; }
	done
}
