# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/shtool/shtool-1.5.1-r1.ebuild,v 1.2 2001/02/27 03:06:16 drobbins Exp $

A=shtool-1.5.1.tar.gz
S=${WORKDIR}/shtool-1.5.1
DESCRIPTION="A compilation of small but very stable and portable shell scripts into a single shell tool"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/shtool/${A}
	 ftp://ftp.gnu.org/gnu/shtool/${A}"
HOMEPAGE="http://www.gnu.org/software/shtool/shtool.html"
DEPEND=""
RDEPEND=">=sys-apps/bash-2.04
	 >=sys-devel/perl-5.6"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try pmake

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr install
    dodoc AUTHORS ChangeLog COPYING README THANKS VERSION
}

