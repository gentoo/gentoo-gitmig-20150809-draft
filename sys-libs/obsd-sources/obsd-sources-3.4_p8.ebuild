# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/obsd-sources/obsd-sources-3.4_p8.ebuild,v 1.2 2003/12/07 16:09:38 g2boojum Exp $

DESCRIPTION="OpenBSD userland and kernel sources"
HOMEPAGE="http://www.openbsd.com/"
SRC_URI="ftp://ftp.openbsd.org/pub/OpenBSD/3.4/src.tar.gz
	ftp://ftp.openbsd.org/pub/OpenBSD/3.4/sys.tar.gz
	ftp://ftp.openbsd.org/pub/OpenBSD/patches/3.4/common/008_sem.patch
	ftp://ftp.openbsd.org/pub/OpenBSD/patches/3.4/common/007_uvm.patch
	ftp://ftp.openbsd.org/pub/OpenBSD/patches/3.4/common/005_exec.patch
	ftp://ftp.openbsd.org/pub/OpenBSD/patches/3.4/common/004_httpd.patch
	ftp://ftp.openbsd.org/pub/OpenBSD/patches/3.4/common/003_arp.patch
	ftp://ftp.openbsd.org/pub/OpenBSD/patches/3.4/common/002_asn1.patch
	ftp://ftp.openbsd.org/pub/OpenBSD/patches/3.4/i386/006_ibcs2.patch"
LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="x86obsd"

DEPEND=""
S=${WORKDIR}

src_unpack() {
	cd ${S}
	unpack src.tar.gz sys.tar.gz
	epatch ${DISTDIR}/002_asn1.patch
	epatch ${DISTDIR}/003_arp.patch
	epatch ${DISTDIR}/004_httpd.patch
	epatch ${DISTDIR}/005_exec.patch
	epatch ${DISTDIR}/006_ibcs2.patch
	epatch ${DISTDIR}/007_uvm.patch
	epatch ${DISTDIR}/008_sem.patch
}

src_compile() {
	echo "nothing to compile"
}

src_install() {
	dodir /usr/src
	cp -R * ${D}/usr/src
}

