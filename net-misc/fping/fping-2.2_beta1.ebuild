# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/net-misc/fping/fping-2.2_beta1.ebuild,v 1.1 2000/12/17 17:48:05 achim Exp $

S=${WORKDIR}/fping-2.2b1
DESCRIPTION="A utility to ping multiple hosts at once"
SRC_URI="ftp://ftp.kernel.org/pub/software/admin/mon/fping-2.2b1.tar.bz2"
HOMEPAGE="http://www.stanford.edu/~schemers/docs/fping/fping.html"

src_unpack() {
  unpack ${A}
  cp ${FILESDIR}/fping.c ${S}
}
 
src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    dobin fping
    doman fping.8
    dodoc COPYING ChangeLog README

}

