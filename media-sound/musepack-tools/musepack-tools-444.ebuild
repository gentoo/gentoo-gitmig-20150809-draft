# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/musepack-tools/musepack-tools-444.ebuild,v 1.5 2009/07/26 19:36:59 halcy0n Exp $

inherit cmake-utils

# svn co http://svn.musepack.net/libmpc/trunk musepack-tools-${PV}
# tar -cjf musepack-tools-${PV}.tar.bz2 musepack-tools-${PV}

DESCRIPTION="Musepack SV8 libraries and utilities"
HOMEPAGE="http://www.musepack.net"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="BSD LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/libcuefile-${PV}
	>=media-libs/libreplaygain-${PV}"
DEPEND="${RDEPEND}
	!media-sound/mppenc
	!media-libs/libmpcdec"

PATCHES=( "${FILESDIR}/${P}-gentoo.patch" )

src_install() {
	cmake-utils_src_install
	insinto /usr/include/mpc
	doins include/mpc/*.h || die "doins failed"
	dosym mpc /usr/include/mpcdec || die "dosym failed"
}
