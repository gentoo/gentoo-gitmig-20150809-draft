# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-arch/rpm/rpm-3.0.5.ebuild,v 1.4 2000/10/23 11:27:12 achim Exp $

P=rpm-3.0.5
A="${P}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="Red Hat Package Management Utils"
SRC_URI="ftp://ftp.rpm.org/pub/rpm/dist/rpm-3.0.x/${A}"
HOMEPAGE="http://www.rpm.org/"


src_compile() {
    cd ${S}
    try ./configure --prefix=/usr --with-catgets
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
  ${ROOT}/usr/bin/rpm --initdb --root=${ROOT}
}



