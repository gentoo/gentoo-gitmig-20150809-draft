# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-nds/openldap/openldap-1.2.11-r2.ebuild,v 1.3 2001/05/29 17:28:19 achim Exp $

A=${PN}-stable-20000704.tgz
S=${WORKDIR}/${P}
DESCRIPTION="LDAP suite of application and development tools"
SRC_URI="ftp://ftp.OpenLDAP.org/pub/OpenLDAP/openldap-stable/"${A}
HOMEPAGE="http://www.OpenLDAP.org/"

DEPEND="virtual/glibc
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	>=sys-libs/ncurses-5.1
	>=sys-libs/gdbm-1.8.0"

RDEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	>=sys-libs/gdbm-1.8.0"

src_compile() {
  local myconf
  if [ "`use tcpd`" ] ; then
    myconf="--enable-wrappers"
  fi
  ./configure --host=${CHOST} --enable-passwd \
	      --enable-shell --enable-shared --enable-static \
	      --prefix=/usr --sysconfdir=/etc --localstatedir=/var/lib \
	      --with-ldbm-api=gdbm \
	      --mandir=/usr/share/man --libexecdir=/usr/lib $myconf
  try make depend
  try make
  cd tests
  make
}

src_install() {                               
  cd ${S}
  make prefix=${D}/usr sysconfdir=${D}/etc/openldap localstatedir=${D}/var/lib	\
	mandir=${D}/usr/share/man libexecdir=${D}/usr/lib install

  dodoc ANNOUNCEMENT CHANGES COPYRIGHT README LICENSE
  docinto rfc
  dodoc doc/rfc/*.txt
  docinto devel
  dodoc doc/devel/*
 
  dodir /etc/rc.d/init.d
  cp ${O}/files/slapd ${D}/etc/rc.d/init.d
  cp ${O}/files/slurpd ${D}/etc/rc.d/init.d

  cd ${D}/etc/openldap

  for i in *
  do
    cp $i $i.orig
    sed -e "s:${D}::" $i.orig > $i
    rm $i.orig
  done
}





