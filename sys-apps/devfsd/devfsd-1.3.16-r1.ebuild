# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins et al <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/devfsd/devfsd-1.3.16-r1.ebuild,v 1.2 2001/08/21 05:30:01 drobbins Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Daemon for the Linux Device Filesystem"
SRC_URI="ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd-v${PV}.tar.gz"
HOMEPAGE="http://www.atnf.csiro.au/~rgooch/linux/"
DEPEND="virtual/glibc >=sys-apps/devfsd-1.3.16-r1"

src_unpack() {
  	unpack ${A}
	cd ${S}
	cp GNUmakefile GNUmakefile.orig
	sed -e "s:-O2:${CFLAGS}:g" -e 's:/usr/man:/usr/share/man:' -e '26,28d;6,7d;9d' GNUmakefile.orig > GNUmakefile
}

src_compile() {
	make || die
}

src_install () {
  	dodir /sbin /usr/share/man /etc
	try make PREFIX=${D} install
	dodir /dev-state
	insinto /etc
	doins ${FILESDIR}/devfsd.conf
}
