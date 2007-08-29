# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cloop/cloop-2.05.ebuild,v 1.2 2007/08/29 18:33:26 genstef Exp $

inherit linux-mod

DESCRIPTION="Compressed filesystem loopback kernel module"
HOMEPAGE="http://packages.debian.org/unstable/source/cloop http://www.knopper.net/knoppix"
SRC_URI="mirror://debian/pool/main/c/cloop/${PN}_${PV}~20060829-1.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${P}~20060829

src_unpack() {
	unpack ${A}
	cd ${S}
	# This should only be applied on Kernel >= 2.6.22
	kernel_is ge 2 6 22 && epatch ${FILESDIR}/${P}-kernel_2.6.22.patch
}

pkg_setup() {
	kernel_is 2 4 && die "kernel 2.4 is not supported"
	CONFIG_CHECK="ZLIB_INFLATE"
	MODULE_NAMES="cloop(fs:)"
	BUILD_TARGETS="all"
	BUILD_PARAMS="KVERSION=${KV_FULL} KERNEL_DIR=${KV_DIR}"
	linux-mod_pkg_setup
}

src_install() {
	linux-mod_src_install

	dobin create_compressed_fs extract_compressed_fs
	cp debian/create_compressed_fs.1 debian/extract_compressed_fs.1
	doman debian/create_compressed_fs.1 debian/extract_compressed_fs.1
	dodoc CHANGELOG README
}
