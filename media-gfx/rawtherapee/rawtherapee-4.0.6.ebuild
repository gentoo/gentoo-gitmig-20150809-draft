# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/rawtherapee/rawtherapee-4.0.6.ebuild,v 1.2 2012/05/05 07:00:21 jdhore Exp $

EAPI="4"

inherit cmake-utils toolchain-funcs

DESCRIPTION="Digital photo editing tool focused on RAW image file manipulation and conversion"
HOMEPAGE="http://www.rawtherapee.com/"
SRC_URI="http://dev.gentoo.org/~radhermit/distfiles/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bzip2 doc openmp"

RDEPEND="bzip2? ( app-arch/bzip2 )
	>=dev-cpp/gtkmm-2.12:2.4
	>=dev-cpp/glibmm-2.16:2
	dev-libs/libsigc++:2
	media-libs/tiff
	media-libs/libpng
	media-libs/libiptcdata
	media-libs/lcms:2
	sys-libs/zlib
	virtual/jpeg"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}"/${PN}-4.0.4-nohg.patch )

pkg_setup() {
	if use openmp ; then
		tc-has-openmp || die "Please switch to an openmp compatible compiler"
	fi

	mycmakeargs=(
		$(cmake-utils_use openmp OPTION_OMP)
		$(cmake-utils_use_with bzip2 BZIP)
		-DCREDITSDIR=/usr/share/doc/${PF}
	)
}

src_install() {
	cmake-utils_src_install
	use doc && dodoc doc/built/pdf/en/RawTherapeeManual_4.0.pdf
}
