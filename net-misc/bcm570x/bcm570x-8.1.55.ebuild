# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bcm570x/bcm570x-8.1.55.ebuild,v 1.1 2005/05/06 12:04:17 genstef Exp $

inherit linux-mod

MY_P=${P/570x/5700}
SRC_URI="http://www.broadcom.com/docs/driver_download/570x/linux-${PV}.zip"
DESCRIPTION="Driver for the Broadcom 570x-based gigabit cards (found on many mainboards)."
HOMEPAGE="http://www.broadcom.com/docs/driver-sla.php?driver=570x-Linux"
LICENSE="GPL-2"

KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="app-arch/unzip"

S=${WORKDIR}/${MY_P}

MODULE_NAMES="bcm5700(net:${S}/src)"
BUILD_TARGETS="default"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="LINUX=${KV_DIR}"
}

src_unpack() {
	unpack ${A}
	tar xzpf ${WORKDIR}/linux/${MY_P}.tar.gz || \
		die "could not extract second level archive"
	tar xzpf ${WORKDIR}/linux/bcm_sup-${PV}.tar.gz || \
		die "could not extract supplementary archive"
}

src_install() {
	insinto /usr/share/${PN}
	doins ${WORKDIR}/bcm_sup-${PV}/patches/${MY_P}-2.4.29.patch \
		${WORKDIR}/bcm_sup-${PV}/patches/${MY_P}-2.6.11.patch

	linux-mod_src_install

	dodoc DISTRIB.TXT README.TXT RELEASE.TXT

	cd ${S}/src
	doman bcm5700.4
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo "For more detailed information about this driver:"
	einfo "man 4 bcm5700"
	einfo "If you prefer patching your kernel,"
	einfo "you can find kernel patches in /usr/share/${PN}"
}
