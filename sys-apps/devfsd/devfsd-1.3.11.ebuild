# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/devfsd/devfsd-1.3.11.ebuild,v 1.2 2001/02/27 23:03:15 achim Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Daemon for the Lunx Device Filesystem"
SRC_URI="ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd-v${PV}.tar.gz"
HOMEPAGE="http://www.atnf.csiro.au/~rgooch/linux/"

src_unpack() {

  unpack ${A}
  cd ${S}
  patch -p0 < ${FILESDIR}/${P}-GNUmakefile-gentoo.diff

}

src_compile() {

    try make
}

src_install () {

  try make DESTDIR=${D} install

 exeinto /etc/rc.d/init.d
 doexe ${FILESDIR}/devfsd

}

pkg_postinst () {

  rc-update add devfsd

}

