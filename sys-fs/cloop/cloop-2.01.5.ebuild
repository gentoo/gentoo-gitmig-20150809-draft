# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cloop/cloop-2.01.5.ebuild,v 1.1 2004/11/23 22:50:05 genstef Exp $

inherit kernel-mod eutils versionator

DESCRIPTION="Compressed filesystem loopback kernel module"
HOMEPAGE="http://www.knopper.net/knoppix/"
SRC_URI="http://developer.linuxtag.net/knoppix/sources/${PN}_$(replace_version_separator 2 '-').tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S=${WORKDIR}/${PN}-$(get_version_component_range 1-2)

pkg_setup() {
	if kernel-mod_is_2_4_kernel ;
	then
		kernel-mod_configoption_present ZLIB_DEFLATE || \
			die "You need ZLIB_DEFLATE support in your kernel!"
	fi
	kernel-mod_configoption_present ZLIB_INFLATE || \
		die "You need ZLIB_INFLATE support in your kernel!"
	kernel-mod_check_modules_supported
}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/kernel26_amd64.patch
	kernel-mod_is_2_6_kernel && [ "${KV_PATCH}" -gt 7 ] && epatch ${FILESDIR}/kernel-2.6.8-fs_h-fix.patch
	cd ${S}
	epatch ${FILESDIR}/cloop.fix.patch
}

src_compile() {
	kernel-mod_src_compile
}

src_install() {
	insinto /lib/modules/${KV_VERSION_FULL}/misc
	kernel-mod_is_2_4_kernel && doins cloop.o || doins cloop.ko
	dobin create_compressed_fs extract_compressed_fs
	cp debian/create_compressed_fs.1 debian/extract_compressed_fs.1
	doman debian/create_compressed_fs.1 debian/extract_compressed_fs.1
	dodoc CHANGELOG README
}

pkg_postinst () {
	if kernel-mod_is_2_4_kernel ; then
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

	einfo "Checking kernel module dependencies"
	test -r "${ROOT}/usr/src/linux/System.map" && \
		depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}
}
