# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-nds/openldap/openldap-2.0.11.ebuild,v 1.2 2001/06/11 10:56:47 achim Exp $

A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="LDAP suite of application and development tools"
SRC_URI="ftp://ftp.OpenLDAP.org/pub/OpenLDAP/openldap-release/"${A}
HOMEPAGE="http://www.OpenLDAP.org/"

DEPEND="virtual/glibc
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
        ssl? ( >=dev-libs/openssl-0.9.6 )
        readline? ( >=sys-libs/readline-4.1 )
	>=sys-libs/ncurses-5.1
        gdbm? ( >=sys-libs/gdbm-1.8.0 )"

RDEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
        gdbm? ( >=sys-libs/gdbm-1.8.0 )"


src_compile() {
  local myconf
  if [ "`use tcpd`" ] ; then
    myconf="--enable-wrappers"
  fi
  if [ "`use ssl`" ] ; then
    myconf="$myconf --with-tls"
  else
    myconf="$myconf --without-tls"
  fi
  if [ "`use readline`" ] ; then
    myconf="$myconf --with-readline"
  else
    myconf="$myconf --without-readline"
  fi
  if [ "`use gdbm`" ] ; then
     myconf="$myconf --enable-ldbm --with-ldbm-api=gdbm"
  else
     myconf="$myconf --disable-ldbm"
  fi
  try ./configure --host=${CHOST} --enable-passwd \
	      --enable-shell --enable-shared --enable-static --enable-ipv6 \
	      --prefix=/usr --sysconfdir=/etc --localstatedir=/var/state \
              --mandir=/usr/share/man  --libexecdir=/usr/lib/openldap $myconf
  try make depend
  try make
  cd tests
  try make
}

src_install() {

  try make prefix=${D}/usr sysconfdir=${D}/etc/openldap \
        localstatedir=${D}/var/state mandir=${D}/usr/share/man libexecdir=${D}/usr/lib/openldap  install

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
    dosed $i
  done

}






