# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cloop/cloop-0.68.ebuild,v 1.2 2003/08/26 13:34:47 stuart Exp $

inherit kernel-mod

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

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

S=${WORKDIR}/${PN}-${PV}

badversion () {
	eerror "This version of cloop will only compile against Linux 2.4.x"
	eerror "Please change where /usr/src/linux points to, or export the KERNEL_DIR"
	eerror "environment variable like this:"
	eerror
	eerror "  KERNEL_DIR=\"<dir>\" emerge cloop"

	die "cloop ${PV} only works with Linux 2.4"
}

src_compile() {
	kernel-mod_getversion

	[ "$KV_MAJOR" = "2" ] && [ "$KV_MINOR" != "4" ] && badversion

	kernel-mod_src_compile
}

src_install() {
	insinto /lib/modules/$KV_VERSION_FULL/misc
	doins cloop.o
	dobin create_compressed_fs compressloop
	doman debian/create_compressed_fs.1
	dodoc CHANGELOG README
}

pkg_postinst () {
	einfo "Adding /dev/cloop device"
	if [ -e /dev/cloop ] ; then
		rm -f /dev/cloop
	fi
	mknod /dev/cloop b 240 0 || die
}
