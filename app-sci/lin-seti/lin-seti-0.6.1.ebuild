# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/lin-seti/lin-seti-0.6.1.ebuild,v 1.1 2003/03/19 20:42:23 tantive Exp $

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
	
}
