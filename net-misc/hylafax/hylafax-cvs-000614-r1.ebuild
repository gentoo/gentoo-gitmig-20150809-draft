# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/hylafax/hylafax-cvs-000614-r1.ebuild,v 1.6 2001/05/29 13:32:32 achim Exp $

P=hylafax-cvs-000614
A="${P}.tar.bz2 ${P}.patch.gz"
S=${WORKDIR}/hylafax
DESCRIPTION="HylaFAX Faxserver"
SRC_URI="ftp://gentoolinux.sourceforge.net/pub/gentoolinux/current/distfiles/${P}.tar.bz2"
HOMEPAGE="http://www.hylafax.org"

DEPEND="virtual/glibc
	>=sys-devel/gcc-2.95.2
	>=media-libs/tiff-3.5.5
	>=media-libs/jpeg-6b"

src_unpack() {
  unpack ${P}.tar.bz2
  cd ${S}
  zcat ${DISTDIR}/${P}.patch.gz | patch -p1
  cd ..
  patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {

  try make
}

src_install() {

  dodir /usr/bin
  dodir /usr/sbin
  dodir /usr/lib/fax
  dodir /usr/lib/hylafax
  dodir /usr/share/man
  dodir /var/spool/fax
  dodir /etc/rc.d/init.d
  try make BASEDIR=${D} install

  dodoc COPYRIGHT README TODO VERSION
  docinto html
  dodoc html/*.html html/*.gif
  for i in Majordomo Modems Modems/Hayes Modems/Supra Modems/Telebit \
	   Modems/ZyXEL
  do
    docinto html/$i
    dodoc html/$i/*.html
  done
  docinto html/icons
  dodoc html/icons/*.gif
}





