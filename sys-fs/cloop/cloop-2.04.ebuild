# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cloop/cloop-2.04.ebuild,v 1.4 2006/12/08 07:06:04 zmedico Exp $

inherit linux-mod eutils

DESCRIPTION="Compressed filesystem loopback kernel module"
HOMEPAGE="http://packages.debian.org/unstable/source/cloop http://www.knopper.net/knoppix"
SRC_URI="mirror://debian/pool/main/c/cloop/${PN}_${PV}-1+eb.1-7.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

S=${WORKDIR}/${P}-1+eb.1

pkg_setup() {
	CONFIG_CHECK="ZLIB_INFLATE"
	if kernel_is 2 4
	then
		die "kernel 2.4 is not supported"
	fi
	MODULE_NAMES="cloop(fs:)"
	BUILD_TARGETS="all"
	BUILD_PARAMS="KVERSION=${KV_FULL} KERNEL_DIR=${KV_DIR}"
	linux-mod_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:MODULE_PARM(\([^,]*\), "s");:module_param(\1, charp, 0);:' compressed_loop.c
	sed -i -e 's:__stringify(KBUILD_MODNAME):"cloop":' compressed_loop.c
}

src_install() {
	linux-mod_src_install

	dobin create_compressed_fs extract_compressed_fs
	cp debian/create_compressed_fs.1 debian/extract_compressed_fs.1
	doman debian/create_compressed_fs.1 debian/extract_compressed_fs.1
	dodoc CHANGELOG README
}
