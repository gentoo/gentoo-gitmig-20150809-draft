# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/ximian-connector/ximian-connector-1.2.0.ebuild,v 1.1 2002/11/20 01:54:36 nall Exp $

DESCRIPTION="Ximian Connector (An Evolution Plugin to talk to Exchange Servers)"
HOMEPAGE="http://www.ximian.com"
LICENSE="Ximian-Connector"
SLOT="0"
KEYWORDS="~ppc -sparc -sparc64 -alpha"

XIMIAN_ARCH="blargh"
XIMIAN_DIST="frobs"

if [ `use ppc` ]; then
	XIMIAN_DIST="yellowdog-22-ppc"
	XIMIAN_ARCH="ppc"
elif [ `use x86` ]; then
	XIMIAN_DIST="redhat-73-i386"
	XIMIAN_ARCH="i386"
fi

XIMIAN_REV=$(( `echo ${PR} | sed -e "s/r//"` + 1 ))

SRC_URI="http://www-files.ximian.com/${PN}/${XIMIAN_DIST}/${P}-${XIMIAN_REV}.ximian.${XIMIAN_REV}.${XIMIAN_ARCH}.rpm"

DEPEND="app-arch/rpm2targz
        >=net-mail/evolution-1.2.0*"
RDEPEND=">=net-mail/evolution-1.2.0*"

src_unpack() {
	rpm2targz ${DISTDIR}/${A}
	mv ${WORKDIR}/${P}-${XIMIAN_REV}.ximian.${XIMIAN_REV}.${XIMIAN_ARCH}.tar.gz ${DISTDIR}
	unpack ${P}-${XIMIAN_REV}.ximian.${XIMIAN_REV}.${XIMIAN_ARCH}.tar.gz
}

src_install() {
	cd ${WORKDIR}
	cp -dpR * ${D}
	dosym /usr/lib/libssl.so /usr/lib/libssl.so.2
	dosym /usr/lib/libcrypto.so /usr/lib/libcrypto.so.2
}
