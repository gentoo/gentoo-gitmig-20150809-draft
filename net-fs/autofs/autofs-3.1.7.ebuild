# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-fs/autofs/autofs-3.1.7.ebuild,v 1.1 2000/11/26 20:54:18 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Automounter"
SRC_URI="ftp://ftp.kernel.org/pub/linux/daemons/autofs/${A}
	 ftp://ftp.de.kernel.org/pub/linux/daemons/autofs/${A}
	 ftp://ftp.uk.kernel.org/pub/linux/daemons/autofs/${A}"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {                           
  cd ${S}
  try ./configure --host=${HOST} --prefix=/usr
  try make
}

src_install() {                               
  cd ${S}
  into /usr
  dosbin daemon/automount
  insinto /usr/lib/autofs
  insopts -m 755
  doins   modules/*.so
  dodoc COPYING COPYRIGHT NEWS README* TODO
  cd man
  doman auto.master.5 autofs.5 autofs.8 automount.8
  cd ../samples
  dodir /etc/autofs
  cp ${O}/files/auto.master ${D}/etc/autofs
  cp ${O}/files/auto.misc ${D}/etc/autofs
  dodir /etc/rc.d/init.d
  cp ${O}/files/autofs ${D}/etc/rc.d/init.d
}

pkg_config() {
  . ${ROOT}/etc/rc.d/config/functions
  echo "Activating autofs..."
  ${ROOT}/usr/sbin/rc-update add autofs
}

