# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/fcpci/fcpci-3.11.02-r1.ebuild,v 1.3 2005/03/09 06:34:58 mrness Exp $

inherit flag-o-matic linux-mod

PV_K24=fcpci-suse8.2-0${PV}.tar.gz
PV_K26=fcpci-suse9.1-${PV/.0/-0}.tar.gz

DESCRIPTION="CAPI4Linux drivers for AVM Fritz!Card PCI"
HOMEPAGE="http://www.avm.de/"
SRC_URI="ftp://ftp.avm.de/cardware/fritzcrd.pci/linux/suse.82/${PV_K24}
	ftp://ftp.avm.de/cardware/fritzcrd.pci/linux/suse.91/${PV_K26}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/linux-sources"

S="${WORKDIR}/fritz"

BUILD_TARGETS="all"

pkg_setup() {
	linux-mod_pkg_setup
	if kernel_is 2 4; then
		MODULE_NAMES="fcpci(extra::src.drv)"
	else
		MODULE_NAMES="fcpci(extra::src)"
	fi
}

src_unpack() {
	if kernel_is 2 4; then
		unpack ${PV_K24}

		sed -i -e "s/\`uname -r\`/${KV_VERSION_FULL}/" \
			-e 's/-DMODULE/-DMODULE -DMODVERSIONS/' \
			-e "s:(DEFINES) -O2:(DEFINES) ${CFLAGS} -I /usr/src/linux/include/ -include linux/modversions.h:" \
			${S}/src.drv/makefile || die "sed failed"

		#gentoo-sources contains this typedef
		sed -i -e "s:^typedef void irqreturn_t;.*:/*&*/:" \
			${S}/src.drv/defs.h || die "sed failed"
	else
		unpack ${PV_K26}

		sed -i -e 's:SUBDIRS=:M=:' \
			-e 's:/var/lib/fritz:${S}/lib:' \
			-e "s:\(.*@cp.*\):#\1:" ${S}/src/Makefile || die "sed failed"
	fi
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
