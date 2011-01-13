# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/indilib/indilib-0.7.2.ebuild,v 1.1 2011/01/13 13:19:20 scarabeus Exp $

EAPI=3

MY_P="lib${PN/lib/}_${PV}"

inherit cmake-utils eutils

DESCRIPTION="INDI Astronomical Control Protocol library"
HOMEPAGE="http://indi.sourceforge.net/index.php/Main_Page"
SRC_URI="mirror://sourceforge/${PN/lib/}/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="fits nova usb v4l2"

# libfli: not in portage
# fli? ( >=sci-libs/fli-1.71 )
RDEPEND="
	sys-libs/zlib
	fits? ( >=sci-libs/cfitsio-3.140 )
	nova? ( >=sci-libs/libnova-0.12.1 )
	usb? ( virtual/libusb:0 )
	v4l2? ( >=sys-kernel/linux-headers-2.6 )
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/0.6.2-fix_fits_harddep.patch"
	"${FILESDIR}/0.6.2-fix_symlinks.patch"
	"${FILESDIR}/${PV}-fix_pkgconfig.patch"
	"${FILESDIR}/${PV}-fix_linking_pthread.patch"
)

S="${WORKDIR}/${MY_P/_/-}"

src_prepare() {
	base_src_prepare

	# fix multilib
	sed -i \
		-e "s:\${LIB_POSTFIX}:\${LIB_SUFFIX}:g" \
		CMakeLists.txt || die "sed failed"
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with usb)
		$(cmake-utils_use_with fits CFITSIO)
		$(cmake-utils_use_with nova)
	"
	cmake-utils_src_configure
}
