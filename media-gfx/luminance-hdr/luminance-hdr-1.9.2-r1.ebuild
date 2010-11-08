# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/luminance-hdr/luminance-hdr-1.9.2-r1.ebuild,v 1.2 2010/11/08 22:53:28 maekke Exp $

EAPI="1"

inherit eutils qt4

MY_PN="qtpfsgui"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Qtpfsgui is a graphical user interface that provides a workflow for HDR imaging."
HOMEPAGE="http://qtpfsgui.sourceforge.net"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

LANGS="cs de es fr it pl ru tr"
for lang in ${LANGS} ; do
	IUSE="${IUSE} linguas_${lang}"
done

DEPEND="
	media-gfx/dcraw
	>=media-gfx/exiv2-0.14
	>=media-libs/openexr-1.2.2-r2
	>=media-libs/tiff-3.8.2-r2
	>=sci-libs/fftw-3.0.1-r2
	virtual/jpeg
	x11-libs/qt-core:4
	x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${MY_P}-trunk.patch"

	# no insane CXXFLAGS
	sed -i -e '/QMAKE_CXXFLAGS/d' project.pro || die

	# no stripping
	sed -i -e 's:TARGET:QMAKE_STRIP = true\nTARGET:' project.pro || die
}

src_compile() {
	lrelease project.pro || die
	eqmake4 project.pro PREFIX=/usr || die
	emake || die
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die
	dodoc README TODO || die

	for lang in ${LANGS} ; do
		use linguas_${lang} || rm "${D}"/usr/share/${MY_PN}/i18n/lang_${lang}.qm
	done
}
