# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author:     Ilian Zarov <coder@descom.com>
# Maintainer: Ilian Zarov <coder@descom.com>

S=${WORKDIR}/${P}
DESCRIPTION="p0f performs passive OS detection based on SYN packets."
SRC_URI="http://www.stearns.org/p0f/p0f-1.8.2.tgz"
DEPEND="net-libs/libpcap"

src_compile() {
	patch < ${FILESDIR}/${P}-makefile.patch
	cp ${FILESDIR}/${P}.init p0f.init
	make || die
}

src_install () {
	mkdir -p ${D}/usr/bin
	mkdir -p ${D}/usr/sbin
	mkdir -p ${D}/usr/share/doc
	mkdir -p ${D}/usr/share/man/man1
	mkdir -p ${D}/etc/init.d
	make DESTDIR=${D} install
}

pkg_postinst () {
	einfo "You can start the p0f monitoring program on boot time by running"
	einfo "rc-update add p0f default"
}
