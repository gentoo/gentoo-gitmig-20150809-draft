# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins et al <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/devfsd/devfsd-1.3.11-r1.ebuild,v 1.4 2001/07/09 20:55:12 achim Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Daemon for the Linux Device Filesystem"
SRC_URI="ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd-v${PV}.tar.gz"
HOMEPAGE="http://www.atnf.csiro.au/~rgooch/linux/"
DEPEND="virtual/glibc"

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
 	dodir /etc/devfs/shm
	dodir /dev-state
	insinto /etc
	doins ${FILESDIR}/devfsd.conf
}

pkg_postinst () {
  	rc-update add devfsd
}

