# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ethereal/ethereal-0.8.18.ebuild,v 1.1 2001/06/04 00:16:12 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="ethereal"
SRC_URI="http://ethereal.zing.org/distribution/${A}
	 ftp://ethereal.zing.org/pub/ethereal/${A}"
HOMEPAGE="http://ethereal.zing.org/"

DEPEND="virtual/glibc virtual/x11 sys-devel/perl
	>=net-libs/libpcap-0.5.2 >=sys-libs/zlib-1.1.3
        ssl? ( dev-libs/openssl-0.9.6a )
        snmp? ( net-analyzer/ucd-snmp-4.1.2 )"

RDEPEND="virtual/glibc virtual/x11
	>=sys-libs/zlib-1.1.3
        ssl? ( dev-libs/openssl-0.9.6a )
        snmp? ( net-analyzer/ucd-snmp-4.1.2 )"

src_compile() {
  if [ "`use ssl`" ] ; then
    myconf="--with-ssl=/usr"
  else
    myconf="--without-ssl"
  fi
  if [ "`use snmp`" ] ; then
    myconf="--enable-snmp"
  else
    myconf="--disable-snmp"
  fi

  LDFLAGS="-L/usr/lib -lz" try ./configure --host=${CHOST} --prefix=/usr --with-plugindir=/usr/lib/ethereal/plugins/${PV} \
	--sysconfdir=/etc/ethereal --enable-pcap --enable-zlib --enable-ipv6 $myconf
  try make
}

src_install() {

  dodir /usr/lib/ethereal/plugins/${PV}
  try make prefix=${D}/usr sysconfdir=${D}/etc/ethereal \
	plugindir=${D}/usr/lib/ethereal/plugins/${PV} install
  dodoc AUTHORS COPYING ChangeLog INSTALL.* NEWS README* TODO

}



