# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-fs/autofs/autofs-3.1.7-r1.ebuild,v 1.2 2001/05/28 05:24:13 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Automounter"
SRC_URI="ftp://ftp.kernel.org/pub/linux/daemons/autofs/${A}
	 ftp://ftp.de.kernel.org/pub/linux/daemons/autofs/${A}
	 ftp://ftp.uk.kernel.org/pub/linux/daemons/autofs/${A}"

DEPEND="virtual/glibc
        ldap? ( =net-nds/openlpad-1.2.11-r2 )"

src_unpack() {
  unpack ${A}
  cd ${S}/include
  patch -p0 < ${FILESDIR}/automount.diff
}

src_compile() {
  local myconf
  if [ -z "`use ldap`" ] ; then
    myconf="--without-openldap"
  fi
  try ./configure --host=${HOST} --prefix=/usr $myconf
  try make
}

src_install() {

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

