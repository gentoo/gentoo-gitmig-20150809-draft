# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/freeradius/freeradius-0.8.1.ebuild,v 1.2 2002/12/12 00:24:33 rphillips Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Free RADIUS server with MySQL support"
SRC_URI="ftp://ftp.freeradius.org/pub/radius/freeradius.tar.gz"
HOMEPAGE="http://www.freeradius.org"
KEYWORDS="~x86"
LICENSE="GPL"
SLOT="0"

DEPEND="sys-devel/gcc"

src_compile() {

  ./configure --with-gnu-ld --with-snmp=no --prefix=/usr --sysconfdir=/etc --host=${CHOST} || die
  make all || die
	
}

src_install() {

  dodir /etc/raddb

  make prefix=${D}/usr mandir=${D}/usr/share/man sysconfdir=${D}/etc install || die

  dodoc COPYRIGHT CREDITS INSTALL LICENSE README 

}

