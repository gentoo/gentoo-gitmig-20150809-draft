# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/indilib/indilib-0.6.ebuild,v 1.10 2011/10/30 15:47:38 ssuominen Exp $

EAPI="2"

MY_P="lib${PN/lib/}0_${PV}"

inherit cmake-utils eutils

DESCRIPTION="INDI Astronomical Control Protocol library"
HOMEPAGE="http://indi.sourceforge.net/index.php/Main_Page"
SRC_URI="mirror://sourceforge/${PN/lib/}/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 x86"
IUSE="fits nova usb v4l"

# libfli: not in portage
# fli? ( >=sci-libs/fli-1.71 )
RDEPEND="
	sys-libs/zlib
	fits? ( >=sci-libs/cfitsio-3.140 )
	nova? ( >=sci-libs/libnova-0.12.1 )
	usb? ( virtual/libusb:0 )
"
DEPEND="${RDEPEND}
	v4l? ( >=sys-kernel/linux-headers-2.6 )
"

S="${WORKDIR}/${MY_P/_/-}"

PATCHES=(
	"${FILESDIR}"/${PV}-fix_symlink.patch
	"${FILESDIR}"/${PV}-multilib.patch
)

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with usb)
		$(cmake-utils_use_with fits CFITSIO)
		$(cmake-utils_use_with nova)
	"
	cmake-utils_src_configure
}
