# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ethereal/ethereal-0.8.17a.ebuild,v 1.1 2001/04/29 22:50:16 achim Exp $

A=${PN}-0.8.17-a.tar.gz
S=${WORKDIR}/${PN}-0.8.17
DESCRIPTION="ethereal"
SRC_URI="http://ethereal.zing.org/distribution/${A}
	 ftp://ethereal.zing.org/pub/ethereal/${A}"
HOMEPAGE="http://ethereal.zing.org/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=dev-libs/glib-1.2.8
	>=x11-libs/gtk+-1.2.8
	>=net-libs/libpcap-0.5.2
	>=x11-base/xfree-4.0.1"

src_compile() {                           
  cd ${S}
  LDFLAGS="-L/usr/lib -lz" try ./configure --host=${CHOST} --prefix=/usr/X11R6 \
	--sysconfdir=/etc/ethereal --disable-snmp
  try make
}

src_install() {                               
  cd ${S}
  dodir /usr/X11R6/lib/ethereal/lugins/${PV}
  try make prefix=${D}/usr/X11R6 sysconfdir=${D}/etc/ethereal \
	plugindir=${D}/usr/X11R6/lib/ethereal/plugins/${PV} install
  dodoc AUTHORS COPYING ChangeLog INSTALL.* NEWS README* TODO

}



