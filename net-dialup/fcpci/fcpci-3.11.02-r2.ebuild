# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/fcpci/fcpci-3.11.02-r2.ebuild,v 1.2 2005/03/18 14:14:26 mrness Exp $

inherit flag-o-matic linux-mod

DESCRIPTION="CAPI4Linux drivers for AVM Fritz!Card PCI for the 2.4 kernel series"
HOMEPAGE="http://www.avm.de/"
SRC_URI="ftp://ftp.avm.de/cardware/fritzcrd.pci/linux/suse.82/fcpci-suse8.2-0${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""

S=${WORKDIR}/fritz

BUILD_TARGETS="all"

pkg_setup() {
	linux-mod_pkg_setup
	if kernel_is 2 4; then
		MODULE_NAMES="fcpci(extra::src.drv)"
	else
		ewarn
		ewarn
		eerror "Please do:"
		echo FRITZCAPI_CARDS="fcpci" emerge fritzcapi
		eerror "for 2.6 kernels"

		die kernel too new
	fi
}

src_unpack() {
	unpack ${A}

	sed -i -e "s/\`uname -r\`/${KV_VERSION_FULL}/" \
		-e 's/-DMODULE/-DMODULE -DMODVERSIONS/' \
		-e "s:(DEFINES) -O2:(DEFINES) ${CFLAGS} -I /usr/src/linux/include/ -include linux/modversions.h:" \
		${S}/src.drv/makefile || die "sed failed"

	#gentoo-sources contains this typedef
	sed -i -e "s:^typedef void irqreturn_t;.*:/*&*/:" \
		${S}/src.drv/defs.h || die "sed failed"
}

src_compile() {
	filter-flags "-fstack-protector"
	filter-flags "-fstack-protector-all"

	linux-mod_src_compile
}

src_install () {
	linux-mod_src_install

	dodoc CAPI* compile* license.txt
	dohtml install_passive-?.html
}
