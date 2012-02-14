# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/luminance-hdr/luminance-hdr-2.2.0.ebuild,v 1.2 2012/02/14 09:33:24 radhermit Exp $

EAPI="4"

inherit cmake-utils toolchain-funcs

DESCRIPTION="Luminance HDR is a graphical user interface that provides a workflow for HDR imaging."
HOMEPAGE="http://qtpfsgui.sourceforge.net"
SRC_URI="mirror://sourceforge/qtpfsgui/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LANGS=" cs de es fr fi hu id it pl ro ru tr"
IUSE="${LANGS// / linguas_} openmp"

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

DOCS=( AUTHORS BUGS Changelog README TODO )

PATCHES=(
	# Don't try to define the git version of the release
	"${FILESDIR}"/${P}-no-git.patch

	# Don't install extra docs and fix install dir
	"${FILESDIR}"/${P}-docs.patch

	# Fix openmp automagic support
	"${FILESDIR}"/${P}-openmp-automagic.patch
)

S=${WORKDIR}

pkg_setup() {
	if use openmp ; then
		tc-has-openmp || die "Please switch to an openmp compatible compiler"
	fi
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_use openmp OPENMP)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	for lang in ${LANGS} ; do
		use linguas_${lang} || { rm "${D}"/usr/share/${PN}/i18n/lang_${lang}.qm || die ; }
	done
}
