# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-nds/ypbind/ypbind-1.6-r1.ebuild,v 1.4 2000/09/15 20:09:15 drobbins Exp $

P=ypbind-1.6
A=ypbind-mt-1.6.tar.gz
S=${WORKDIR}/ypbind-mt-1.6
DESCRIPTION="Multithreaded NIS bind service"
SRC_URI="ftp://ftp.de.kernel.org/pub/linux/utils/net/NIS/"${A}
HOMEPAGE="http://www.suse.de/~kukuk/nis/ypbind-mt/index.html"
src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr --sysconfdir=/etc/yp --with-catgets
  try make
}

src_install() {                               
  cd ${S}
  try make DESTDIR=${D} install
  insinto /etc/rc.d/init.d
  doins ${O}/files/ypbind
  dodoc AUTHORS ChangeLog COPYING README THANKS TODO
  insinto /etc/yp
  doins etc/yp.conf
  prepman
}




