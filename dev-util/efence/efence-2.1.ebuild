# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <micke@hallendal.net>
# $Header: /var/cvsroot/gentoo-x86/dev-util/efence/efence-2.1.ebuild,v 1.1 2001/08/25 23:41:26 hallski Exp $

A=ElectricFence-${PV}.tar.gz
S=${WORKDIR}/ElectricFence-${PV}
DESCRIPTION="malloc() debugger for Linux and Unix."
SRC_URI="ftp://ftp.perens.com/pub/ElectricFence/${A}"
HOMEPAGE="http://perens.com/FreeSoftware/"

DEPEND="virtual/glibc"

src_unpack() {
    unpack ${A}
    cd ${S}
    patch -p0 < ${FILESDIR}/gentoo-efence.patch
}

src_compile() {
    emake || die
}

src_install () {
    dolib.a libefence.a
    doman libefence.3

    dodoc CHANGES COPYING README

}





