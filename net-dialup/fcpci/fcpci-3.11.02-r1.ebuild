# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/fcpci/fcpci-3.11.02-r1.ebuild,v 1.1 2004/11/13 19:38:34 mrness Exp $

inherit flag-o-matic kernel-mod

PV_K24=fcpci-suse8.2-0${PV}.tar.gz
PV_K26=fcpci-suse9.1-${PV/.0/-0}.tar.gz

DESCRIPTION="CAPI4Linux drivers for AVM Fritz!Card PCI"
HOMEPAGE="http://www.avm.de/"
S="${WORKDIR}/fritz"
SRC_URI="ftp://ftp.avm.de/cardware/fritzcrd.pci/linux/suse.82/${PV_K24}
	ftp://ftp.avm.de/cardware/fritzcrd.pci/linux/suse.91/${PV_K26}"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/linux-sources"

src_unpack() {
	if kernel-mod_is_2_4_kernel; then
		unpack ${PV_K24}
	else
		unpack ${PV_K26}
	fi
}

src_compile() {
	if kernel-mod_is_2_4_kernel; then
		sed -i -e "s/\`uname -r\`/${KV_VERSION_FULL}/" \
			-e 's/-DMODULE/-DMODULE -DMODVERSIONS/' \
			-e "s:(DEFINES) -O2:(DEFINES) ${CFLAGS} -I /usr/src/linux/include/ -include linux/modversions.h:" src.drv/makefile

		#gentoo-sources contains this typedef
		sed -i -e "s:^typedef void irqreturn_t;.*:/*&*/:" src.drv/defs.h
	else
		sed -i -e 's:SUBDIRS=:M=:' \
			-e 's:/var/lib/fritz:${S}/lib:' \
			-e "s:\(.*@cp.*\):#\1:" ${S}/src/Makefile || die "sed failed"
	fi

	filter-flags "-fstack-protector"
	filter-flags "-fstack-protector-all"
	(
		unset ARCH
		emake all || die "make failed"
	)
}

src_install () {
	if kernel-mod_is_2_4_kernel; then
		insinto /lib/modules/${KV}/misc
		doins src.drv/fcpci.o || die "failed to install fcpci.o"
	else
		insinto /lib/modules/${KV}/misc
		doins src/fcpci.ko || die "failed to install fcpci.ko"
	fi

	dodoc CAPI* compile* license.txt
	dohtml install_passive-?.html
}
