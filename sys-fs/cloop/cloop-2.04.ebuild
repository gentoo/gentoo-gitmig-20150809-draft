# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cloop/cloop-2.04.ebuild,v 1.1 2006/10/19 17:30:35 genstef Exp $

inherit linux-mod eutils

DESCRIPTION="Compressed filesystem loopback kernel module"
HOMEPAGE="http://packages.debian.org/unstable/source/cloop http://www.knopper.net/knoppix"
SRC_URI="mirror://debian/pool/main/c/cloop/${PN}_${PV}-1+eb.1-7.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${P}-1+eb.1

pkg_setup() {
	CONFIG_CHECK="ZLIB_INFLATE"
	if kernel_is 2 4
	then
		CONFIG_CHECK="${CONFIG_CHECK} ZLIB_DEFLATE"
	fi
	MODULE_NAMES="cloop(fs:)"
	BUILD_TARGETS="all"
	BUILD_PARAMS="KVERSION=${KV_FULL} KERNEL_DIR=${KV_DIR}"
	linux-mod_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd ${S}
	kernel_is 2 4 || sed -i 's:MODULE_PARM(\([^,]*\), "s");:module_param(\1, charp, 0);:' compressed_loop.c
	sed -i -e 's:__stringify(KBUILD_MODNAME):"cloop":' compressed_loop.c
}

src_install() {
	linux-mod_src_install

	dobin create_compressed_fs extract_compressed_fs
	cp debian/create_compressed_fs.1 debian/extract_compressed_fs.1
	doman debian/create_compressed_fs.1 debian/extract_compressed_fs.1
	dodoc CHANGELOG README
}

pkg_postinst () {
	if kernel_is 2 4
	then
		einfo "Adding /dev/cloop devices"
		if [ -e /dev/cloop ] ; then
			rm -f /dev/cloop
		fi
		mknod /dev/cloop b 240 0 || die
		if [ -e /dev/cloop1 ] ; then
			rm -f /dev/cloop1
		fi
		mknod /dev/cloop1 b 240 1 || die
	fi

	linux-mod_pkg_postinst
}
