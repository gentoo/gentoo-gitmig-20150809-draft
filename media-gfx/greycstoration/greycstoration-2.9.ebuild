# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/greycstoration/greycstoration-2.9.ebuild,v 1.1 2008/08/30 22:28:00 calchan Exp $

inherit toolchain-funcs

DESCRIPTION="Image regularization algorithm for denoising, inpainting and resizing"
HOMEPAGE="http://www.greyc.ensicaen.fr/~dtschump/greycstoration/"
SRC_URI="mirror://sourceforge/cimg/GREYCstoration-${PV}.zip"
LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fftw imagemagick jpeg lapack png tiff X"

RDEPEND="fftw? ( >=sci-libs/fftw-3 )
	imagemagick? ( media-gfx/imagemagick )
	jpeg? ( media-libs/jpeg )
	lapack? ( virtual/lapack )
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )
	X? ( x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXrandr )"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/GREYCstoration-${PV}/src"

src_unpack() {
	unpack ${A}
	sed -i -e "s:../CImg.h:CImg.h:" "${S}"/greycstoration.cpp || die "sed failed"
}

src_compile() {
	local MY_CONF

	use X && MY_CONF+=" -lX11 -Dcimg_use_xshm -lXext -Dcimg_use_xrandr -lXrandr"
	use png && MY_CONF+=" -Dcimg_use_png -lpng -lz"
	use jpeg && MY_CONF+=" -Dcimg_use_jpeg -ljpeg"
	use tiff && MY_CONF+=" -Dcimg_use_tiff -ltiff"
	use imagemagick && MY_CONF+=" -Dcimg_use_magick $(Magick++-config --cppflags) \
		$(Magick++-config --ldflags) $(Magick++-config --libs)"
	use fftw && MY_CONF+=" -Dcimg_use_fftw3 -lfftw3"
	use lapack && MY_CONF+=" -Dcimg_use_lapack -llapack"

	$(tc-getCXX) -o greycstoration greycstoration.cpp \
		${MY_CONF} -lm -lpthread \
		${CXXFLAGS} ${LDFLAGS} -fno-tree-pre \
		|| die "Compilation failed"
}

src_install() {
	dobin greycstoration
}
