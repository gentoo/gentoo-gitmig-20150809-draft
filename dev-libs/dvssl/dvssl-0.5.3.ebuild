# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvssl/dvssl-0.5.3.ebuild,v 1.1 2003/07/14 20:20:47 pvdabeel Exp $

A=dvssl-${PV}.tar.gz
S=${WORKDIR}/dvssl-${PV}
DESCRIPTION="dvssl provides a simple interface to openssl"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvssl/download/${A}"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvssl/html/"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

IUSE=""
DEPEND="virtual/glibc
	dev-libs/openssl
	dev-libs/dvutil
	dev-libs/dvnet"
RDEPEND=${DEPEND}

src_unpack() {
	unpack ${A}
	cd ${S}
	aclocal
	autoconf
	automake
}

src_install() {
	make DESTDIR=${D} prefix=${D}/usr install || die
}
