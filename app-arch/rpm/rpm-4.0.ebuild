# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-arch/rpm/rpm-4.0.ebuild,v 1.4 2000/11/17 11:15:51 achim Exp $

A="${P}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="Red Hat Package Management Utils"
SRC_URI="ftp://ftp.rpm.org/pub/rpm/dist/rpm-4.0.x/${A}"
HOMEPAGE="http://www.rpm.org/"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3
	>=sys-libs/zlib-1.1.3
	>=sys-apps/bzip2-1.0.1
	>=sys-libs/db-3.1.17
	=sys-libs/db-1.58"


src_compile() {
    cd ${S}
    try ./configure --prefix=/usr
    try make
}

src_install() {
    try make DESTDIR=${D} install
    mv ${D}/bin/rpm ${D}/usr/bin
    rm -rf ${D}/bin
    cd ${S}
    dodoc CHANGES COPYING CREDITS GROUPS README* RPM* TODO
}

pkg_postinst() {
	${ROOT}usr/bin/rpm --initdb --root=${ROOT}
}



