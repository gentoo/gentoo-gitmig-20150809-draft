# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:

DESCRIPTION="A Seti@Home cache manager, cache-compatible with Seti Driver. Can be run as system daemon."
HOMEPAGE="http://lin-seti.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~alpha"
IUSE=""
DEPEND="app-sci/setiathome"

src_compile() {
	emake || die
}

src_install() {
	
  mkdir -m 755 ${D}usr
	mkdir -m 755 ${D}usr/bin
	mkdir -m 755 ${D}opt
	mkdir -m 755 ${D}etc
	mkdir -m 755 ${D}etc/init.d
	make \
	  PREFIX=${D} \
	  install || die

	einfo "NOTICE: If you use SETI Driver for Windows"
	einfo "to share the cache make sure it is"
	einfo "version 1.6.4.0 or higher!"
	einfo
	einfo "If you are updating from a version of lin-seti"
	einfo "prior of 0.7.0, PLEASE update your /etc/lin-seti/lin-setirc"
	einfo "otherwise the program will crash on start!"
	sleep 5
	
}
