# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/musepack-tools/musepack-tools-444.ebuild,v 1.17 2009/10/01 16:09:05 klausman Exp $

inherit cmake-utils

# svn co http://svn.musepack.net/libmpc/trunk musepack-tools-${PV}
# tar -cjf musepack-tools-${PV}.tar.bz2 musepack-tools-${PV}

DESCRIPTION="Musepack SV8 libraries and utilities"
HOMEPAGE="http://www.musepack.net"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="BSD LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/libcuefile-${PV}
	>=media-libs/libreplaygain-${PV}"
DEPEND="${RDEPEND}
	!media-libs/libmpcdec"

PATCHES=( "${FILESDIR}/${P}-gentoo.patch" )

pkg_setup() {
	mycmakeargs="-DSHARED=ON"
}

src_install() {
	cmake-utils_src_install
	dosym mpc /usr/include/mpcdec || die "dosym failed"
	# Forgot to remove .svn directories from snapshot.
	rm -rf "${D}"/usr/include/mpc/.svn || die "rm -rf failed"
}
