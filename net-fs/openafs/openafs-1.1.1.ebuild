# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Holger Brueckner <darks@fet.org>
# $Header: /var/cvsroot/gentoo-x86/net-fs/openafs/openafs-1.1.1.ebuild,v 1.2 2001/08/30 17:31:35 pm Exp $


S=${WORKDIR}/${P}
DESCRIPTION="The AFS 3 distributed file system  targets the issues  critical to
distributed computing environments. AFS performs exceptionally well,
both within small, local work groups of machines and across wide-area
configurations in support of large, collaborative efforts. AFS provides
an architecture geared towards system management, along with the tools
to perform important management tasks. For a user, AFS is a familiar yet
extensive UNIX environment for accessing files easily and quickly."

SRC_URI="http://www.openafs.org/dl/openafs/1.1.1/openafs-1.1.1-src.tar.bz2"
HOMEPAGE="http://www.openafs.org/"

DEPEND="virtual/glibc
        >=sys-libs/ncurses-5.2
	>=sys-libs/pam-0.75"


ARCH=i386_linux24

src_compile() {
  try ./configure --with-afs-sysname=i386_linux24
  try make
}

src_install () {


  # Client

  cd ${S}/${ARCH}/dest/root.client/usr/vice

  insinto /etc/afs/modload
  doins etc/modload/*
  insinto /etc/afs/C
  doins etc/C/*

  insinto /etc/afs
  doins ${FILESDIR}/{ThisCell,CellServDB}
  doins etc/afs.conf

  dodir /afs

  exeinto /etc/rc.d/init.d
  newexe ${FILESDIR}/afs.rc afs

  dosbin etc/afsd

  # Client Bin
  cd ${S}/${ARCH}/dest
  exeinto /usr/afsws/bin
  doexe bin/*

  exeinto /etc/afs/afsws
  doexe etc/*

  cp -a include lib ${D}/usr/afsws
  dosym  /usr/afsws/lib/afs/libtermlib.a /usr/afsws/lib/afs/libnull.a

  # Server
  cd ${S}/${ARCH}/dest/root.server/usr/afs
  exeinto /usr/afs/bin
  doexe bin/*

  dodir /usr/vice
  dosym /etc/afs /usr/vice/etc
  dosym /etc/afs/afsws /usr/afsws/etc

  dodoc ${FILESDIR}/README
}

pkg_postinst () {
   echo ">>> UPDATE CellServDB and ThisCell to your needs !!"
   echo ">>> FOLLOW THE INSTRUCTIONS IN AFS QUICK BEGINNINGS"
   echo ">>> PAGE >45 TO DO INITIAL SERVER SETUP"    fi
}
