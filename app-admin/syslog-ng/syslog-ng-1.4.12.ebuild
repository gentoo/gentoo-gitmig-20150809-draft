# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce Locke <blocke@shivan.org>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Syslog-ng is a syslog replacement with advanced filtering features"
SRC_URI="http://www.balabit.hu/downloads/syslog-ng/1.4/${A}"
HOMEPAGE="http://www.balabit.hu/en/products/syslog-ng/"

RDEPEND="virtual/glibc >=dev-libs/libol-0.2.23"
DEPEND="${RDEPEND} sys-devel/flex"

src_compile() {

  try ./configure --host=${CHOST} --prefix=/usr
  try make CFLAGS="${CFLAGS} -I/usr/include/libol -D_GNU_SOURCE" ${MAKEOPTS} prefix=${D}/usr all

}

src_install() {

  try make prefix=${D}/usr install 

  # make sure man pages are gzip'd
  gzip ${D}/usr/man/man5/syslog-ng.conf.5
  gzip ${D}/usr/man/man8/syslog-ng.8

  dodoc AUTHORS COPYING ChangeLog INSTALL NEWS PORTS README
  dodoc doc/syslog-ng.conf.demo doc/syslog-ng.conf.sample

  # documentation in various forms
  dodir /usr/share/doc/${P}/sgml
  insinto /usr/share/doc/${P}/sgml
  doins doc/sgml/syslog-ng.dvi doc/sgml/syslog-ng.ps doc/sgml/syslog-ng.sgml doc/sgml/syslog-ng.txt
  gzip ${D}/usr/share/doc/${P}/sgml/*
  doins doc/sgml/syslog-ng.html.tar.gz

  # configuration file
  dodir /etc/syslog-ng
  cp doc/syslog-ng.conf.sample ${D}/etc/syslog-ng/syslog-ng.conf

  # init.d file
  dodir /etc/rc.d/init.d
  cp ${FILESDIR}/syslog-ng ${D}/etc/rc.d/init.d

}



