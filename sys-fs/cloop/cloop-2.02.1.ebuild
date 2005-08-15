# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cloop/cloop-2.02.1.ebuild,v 1.1 2005/08/15 09:43:33 genstef Exp $

inherit linux-mod eutils versionator

DESCRIPTION="Compressed filesystem loopback kernel module"
HOMEPAGE="http://www.knopper.net/knoppix/"
SRC_URI="http://knopper.net/${PN}_$(replace_version_separator 2 '-').tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S=${WORKDIR}/${PN}-$(get_version_component_range 1-2)

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
	epatch ${FILESDIR}/${P}-netinet-gentoo.patch

	# Debian uses conf.vars, everyone else uses .config
	sed -i "s:conf.vars:.config:" Makefile
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
