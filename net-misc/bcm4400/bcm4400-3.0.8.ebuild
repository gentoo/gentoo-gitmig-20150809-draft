# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bcm4400/bcm4400-3.0.8.ebuild,v 1.2 2005/01/31 18:49:55 genstef Exp $

inherit linux-mod

SRC_URI="http://www.broadcom.com/docs/driver_download/440x/linux-${PV}.zip"
DESCRIPTION="Driver for the bcm4400 10/100 network card (in the form of kernel modules)."
HOMEPAGE="http://www.broadcom.com"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""
DEPEND="app-arch/unzip"
S=${WORKDIR}/linux/${P}/src

MODULE_NAMES="bcm4400(net:)"
BUILD_PARAMS="BCM_KVER=${KV_MAJOR}.${KV_MINOR} LINUX=${KV_DIR}"
BUILD_TARGETS="default"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/linux
	tar xzpf ${P}.tar.gz
	convert_to_m ${S}/Makefile
}

src_install() {
	linux-mod_src_install
	doman bcm4400.4
	dodoc ../DISTRIB.TXT ../LICENSE ../README.TXT ../RELEASE.TXT
}
