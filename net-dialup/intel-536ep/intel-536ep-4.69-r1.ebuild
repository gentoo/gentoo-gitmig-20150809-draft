# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/intel-536ep/intel-536ep-4.69-r1.ebuild,v 1.1 2005/03/24 15:26:00 mrness Exp $

inherit eutils flag-o-matic linux-mod

DESCRIPTION="Driver for Intel 536EP modem"
HOMEPAGE="http://developer.intel.com/design/modems/products/536ep.htm"
SRC_URI="ftp://aiedownload.intel.com/df-support/6497/eng/${P}.tgz"

LICENSE="Intel"
SLOT="0"
KEYWORDS="~x86"

S=${WORKDIR}/intel-536EP-2.56.76.0
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

src_unpack(){
	unpack ${A}

	cd ${S}
	if kernel_is 2 4; then
		#there is no way of passing this as make parameter
		sed -i -e 's/\$(PSTN_DEF)/-DTARGET_SELAH -DTARGET_LINUX -DLINUX/' coredrv/Makefile
	elif kernel_is ge 2 6 10; then
		#see bug #86331
		epatch ${FILESDIR}/${P}-kernel-2.6.10-tty.patch

		if kernel_is ge 2 6 11; then
			#addapt to power management changes occured in kernel
			epatch ${FILESDIR}/${P}-kernel-2.6.11-pm.patch
		fi
	fi
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
