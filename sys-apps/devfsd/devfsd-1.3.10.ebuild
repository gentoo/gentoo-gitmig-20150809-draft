# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/devfsd/devfsd-1.3.10.ebuild,v 1.1 2000/12/26 12:48:24 achim Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Daemon for the Lunx Device Filesystem"
SRC_URI="ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd-v1.3.10.tar.gz"
HOMEPAGE="http://www.atnf.csiro.au/~rgooch/linux/"

src_unpack() {
  unpack ${A}
  cp ${FILESDIR}/devfsd.h ${S}
}

src_compile() {

    cd ${S}
    try make

}

src_install () {

 into /
 dosbin devfsd
 into /usr
 doman devfsd.8
 insinto /etc
 doins devfsd.conf modules.devfs
}

