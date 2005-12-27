# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/intel-536ep/intel-536ep-4.71.ebuild,v 1.2 2005/12/27 08:36:03 mrness Exp $

inherit linux-mod

DESCRIPTION="Driver for Intel 536EP modem"
HOMEPAGE="http://developer.intel.com/design/modems/products/536ep.htm"
SRC_URI="ftp://aiedownload.intel.com/df-support/9266/eng/${P}.tgz"

LICENSE="Intel"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=""

S=${WORKDIR}/Intel-536
MODULE_NAMES="Intel536(:${S}/coredrv)"

pkg_setup() {
	if kernel_is 2 4; then
		BUILD_TARGETS="536core"
		BUILD_PARAMS="KERNEL_SOURCE_PATH=${KV_DIR} TARGET=TARGET_SELAH"
	else
		BUILD_TARGETS="536core_26"
		BUILD_PARAMS="KERNEL_SOURCE_PATH=${KV_DIR}"
	fi

	linux-mod_pkg_setup
}

src_install() {
	linux-mod_src_install

	#install hamregistry executable
	exeinto /usr/sbin
	doexe ${S}/hamregistry

	#install boot script and config
	exeinto /etc/init.d
	newexe ${FILESDIR}/intel536ep.initd intel536ep
	insinto /etc/conf.d
	newins ${FILESDIR}/intel536ep.confd intel536ep
}
