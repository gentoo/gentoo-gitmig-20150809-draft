# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/sudo/sudo-1.6.3_p5.ebuild,v 1.1 2000/11/21 05:33:58 jerry Exp $

P=sudo-1.6.3p5
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Allows certain users/groups to run commands as root"
SRC_URI="http://www.courtesan.com/sudo/dist/${A}"
HOMEPAGE="http://www.courtesan.com/sudo/"

DEPEND=">=sys-libs/glibc-2.1.3
        >=sys-libs/pam-0.72"

src_compile() {
    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} \
        --with-pam --with-all-insults --disable-path-info
    try make
}

src_install () {
    cd ${S}
    try make prefix=${D}/usr sysconfdir=${D}/etc install
    
    dodoc BUGS CHANGES FAQ LICENSE README TODO UPGRADE sample.*

    cd ${O}/files
    insinto /etc/pam.d
    doins sudo
}

