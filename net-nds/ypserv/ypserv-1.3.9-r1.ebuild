## Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-nds/ypserv/ypserv-1.3.9-r1.ebuild,v 1.4 2000/11/01 04:44:22 achim Exp $

P=ypserv-1.3.9
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="NIS SERVER"
SRC_URI="ftp://ftp.de.kernel.org/pub/linux/utils/net/NIS/${A}
	 ftp://ftp.uk.kernel.org/pub/linux/utils/net/NIS/${A}
	 ftp://ftp.kernel.org/pub/linux/utils/net/NIS/${A}"
HOMEPAGE="http://www.suse.de/~kukuk/nis/ypserv/index.html"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/gdbm-1.8.0
	>=sys-libs/glibc-2.1.3"

src_unpack() {
  unpack ${A}
  cd ${S}
  cp ${O}/files/defs.sed ypmake
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr --sysconfdir=/etc/yp \
	--localstatedir=/var --enable-tcp-wrapper \
	--enable-yppasswd 
  try make
  cd ${S}/ypmake
  sed -f defs.sed Makefile.in > Makefile
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr YPMAPDIR=${D}/var/yp CONFDIR=${D}/etc/yp \
	installdirs install_progs
  prepman

  exeinto /usr/sbin
  cd ${S}/contrib
  doexe ypslave
  cd ${S}/ypmake 
  doexe ypmake
  insinto /usr/lib/yp/ypmake
  for i in aliases arrays automount config ethers group gshadow hosts \
	   netgroup netid networks passwd protocols publickey \
           rpc services shadow ypservers
  do
	doins $i
  done
  insinto /var/yp
  doins ypmake.conf.sample
  newman ypmake.man ypmake.8
  newman ypmake.conf.man ypmake.conf.5
  insinto /etc/rc.d/init.d
  doins ${O}/files/ypserv
  cd ${S}
  dodoc BUGS ChangeLog HOWTO.SuSE NEWS TODO 
  insinto /etc/yp
  doins etc/ypserv.conf
}



