# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-nds/openldap/openldap-2.0.1.ebuild,v 1.1 2000/09/10 16:16:31 achim Exp $

A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="LDAP suite of application and development tools"
SRC_URI="ftp://ftp.OpenLDAP.org/pub/OpenLDAP/openldap-release/"${A}
HOMEPAGE="http://www.OpenLDAP.org/"

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
  prepman

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






