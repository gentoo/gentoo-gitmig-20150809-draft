# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/intel-536ep/intel-536ep-4.71.ebuild,v 1.4 2006/03/28 23:04:02 mrness Exp $

inherit linux-mod

DESCRIPTION="Driver for Intel 536EP modem"
HOMEPAGE="http://developer.intel.com/design/modems/products/536ep.htm"
SRC_URI="ftp://aiedownload.intel.com/df-support/9266/eng/${P}.tgz"

LICENSE="Intel"
SLOT="0"
KEYWORDS="x86"
IUSE=""

S="${WORKDIR}/Intel-536"
MODULE_NAMES="Intel536(:${S}/coredrv)"

pkg_setup() {
	if kernel_is ge 2 6 16; then
		eerror "This driver is not supported by kernels >= 2.6.16."
		eerror "Please see http://bugs.gentoo.org/show_bug.cgi?id=127464 for more info."
		die "unsupported kernel version"
	elif kernel_is 2 4; then
		BUILD_TARGETS="536core"
		BUILD_PARAMS="KERNEL_SOURCE_PATH='${KV_DIR}' TARGET=TARGET_SELAH"
	else
		BUILD_TARGETS="536core_26"
		BUILD_PARAMS="KERNEL_SOURCE_PATH='${KV_DIR}'"
	fi

	linux-mod_pkg_setup
}

src_install() {
	linux-mod_src_install

	#install hamregistry executable
	exeinto /usr/sbin
	doexe "${S}/hamregistry"

	#install boot script and its config
	newinitd "${FILESDIR}/intel536ep.initd" intel536ep
	newconfd "${FILESDIR}/intel536ep.confd" intel536ep
}
