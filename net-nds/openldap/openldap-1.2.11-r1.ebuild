# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-nds/openldap/openldap-1.2.11-r1.ebuild,v 1.6 2000/11/01 06:27:12 achim Exp $

P=openldap-1.2.11
A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="LDAP suite of application and development tools"
SRC_URI="ftp://ftp.OpenLDAP.org/pub/OpenLDAP/openldap-release/"${A}
HOMEPAGE="http://www.OpenLDAP.org/"

DEPEND=">=sys-apps/bash-2.04
	>=sys-apps/tcp-wrappers-7.6
	>=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1"
	
src_compile() { 
  cd ${S}
  ./configure --host=${CHOST} --enable-wrappers --enable-passwd \
	      --enable-shell --enable-shared --enable-static \
	      --prefix=/usr --sysconfdir=/etc --localstatedir=/var/state
  make depend
  make
  cd tests
  make
}

src_install() {                               
  cd ${S}
  make prefix=${D}/usr sysconfdir=${D}/etc/openldap localstatedir=${D}/var/state install

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





