# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/shtool/shtool-1.5.1-r1.ebuild,v 1.1 2000/08/01 05:05:20 drobbins Exp $

A=shtool-1.5.1.tar.gz
S=${WORKDIR}/shtool-1.5.1
CATEGORY="sys-apps"
DESCRIPTION="A compilation of small but very stable and portable shell scripts into a single shell tool"
SRC_URI="ftp://ftp.gnu.org/gnu/shtool/${A}"
HOMEPAGE="http://www.gnu.org/software/shtool/shtool.html"


src_compile() {

    cd ${S}
    ./configure --prefix=/usr --host=${CHOST}
    make

}

src_install () {

    cd ${S}
    make prefix=${D}/usr install
    prepman
}

