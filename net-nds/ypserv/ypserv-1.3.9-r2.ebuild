## Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-nds/ypserv/ypserv-1.3.9-r2.ebuild,v 1.1 2001/04/21 12:44:19 achim Exp $

P=ypserv-1.3.9
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="NIS SERVER"
SRC_URI="ftp://ftp.de.kernel.org/pub/linux/utils/net/NIS/${A}
	 ftp://ftp.uk.kernel.org/pub/linux/utils/net/NIS/${A}
	 ftp://ftp.kernel.org/pub/linux/utils/net/NIS/${A}"
HOMEPAGE="http://www.suse.de/~kukuk/nis/ypserv/index.html"

DEPEND="virtual/glibc >=sys-libs/gdbm-1.8.0
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"

src_unpack() {
  unpack ${A}
  cd ${S}
  cp ${FILESDIR}/defs.sed ypmake
}

src_compile() {                  
  local myconf
  if [ "`use tcpd`" ]
  then
	myconf="--enable-tcp-wrapper"
  fi         
  try ./configure --host=${CHOST} --prefix=/usr --sysconfdir=/etc \
	--localstatedir=/var --mandir=/usr/share/man \
	--enable-yppasswd $myconf
  try make
  cd ${S}/ypmake
  sed -f defs.sed Makefile.in > Makefile
  try make
}

src_install() {                               
  local MYMAN=${D}/usr/share/man
  try make prefix=${D}/usr YPMAPDIR=${D}/var/yp CONFDIR=${D}/etc \
	MAN1DIR=$MYMAN/man1 MAN5DIR=$MYMAN/man5 MAN8DIR=$MYMAN/man8 \
	installdirs install_progs

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
  doins ${FILESDIR}/ypserv
  cd ${S}
  dodoc BUGS ChangeLog HOWTO.SuSE NEWS TODO 
  insinto /etc
  doins etc/ypserv.conf
}



