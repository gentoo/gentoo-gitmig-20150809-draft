# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-arch/rpm/rpm-4.0.ebuild,v 1.3 2000/11/17 01:59:33 drobbins Exp $

A="${P}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="RedHat Package Management Utils"
SRC_URI="ftp://ftp.rpm.org/pub/rpm/dist/rpm-4.0.x/${A}"
HOMEPAGE="http://www.rpm.org/"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3
	>=sys-libs/zlib-1.1.3
	>=sys-apps/bzip2-1.0.1
	>=sys-libs/db-3.1.17
	=sys-libs/db-1.58"

src_unpack() {
        unpack ${A}
        cd ${S}
        cat ${FILESDIR}/rpm-4.0-rpmgettext.patch.bz2 | bzip2 -d | patch -p0
        cat ${FILESDIR}/rpm-rpmlibsucks.patch.bz2 | bzip2 -d | patch -p1
        cat ${FILESDIR}/rpm-4.0-bashort.patch.bz2 | bzip2 -d | patch -p0
        cat ${FILESDIR}/rpm-3.0.3-compile.patch.bz2 | bzip2 -d | patch -p0
        cat ${FILESDIR}/rpm-3.0.3-fakeroot.patch.bz2 | bzip2 -d | patch -p0
        cat ${FILESDIR}/rpm-skipmntpoints.patch.bz2 | bzip2 -d | patch -p1
        cat ${FILESDIR}/rpm-3.0.5-objdump-shutup.patch.bz2 | bzip2 -d | patch -p1
        cat ${FILESDIR}/rpm-wait-for-lock.patch.bz2 | bzip2 -d | patch -p0
        cat ${FILESDIR}/rpm-4.0.1-install-ugid-h.patch.bz2 | bzip2 -d | patch -p1
}

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



