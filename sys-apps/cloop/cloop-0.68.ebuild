# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cloop/cloop-0.68.ebuild,v 1.1 2003/08/25 20:33:17 stuart Exp $

MY_PV="${PV}-3"
MY_P="${PN}_${MY_PV}"
DESCRIPTION="Compressed filesystem loopback kernel module"
HOMEPAGE="http://www.knopper.net/knoppix/"
SRC_URI="http://developer.linuxtag.net/knoppix/sources/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=""

KERNEL_DIR="${KERNEL_DIR:-/usr/src/linux}"

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

S=${WORKDIR}/${PN}-${PV}

src_compile() {

	emake KERNEL_DIR=${KERNEL_DIR} || die
}

src_install() {
	insinto /lib/modules/misc
	doins cloop.o
	dobin create_compressed_fs compressloop
	doman debian/create_compressed_fs.1
	dodoc CHANGELOG README
}

pkg_postinst () {
	einfo "Adding /dev/cloop device"
	mknod /dev/cloop b 240 0 || die
}
