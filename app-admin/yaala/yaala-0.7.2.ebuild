# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/yaala/yaala-0.7.2.ebuild,v 1.1 2004/05/14 16:21:02 lostlogic Exp $

SRC_URI="http://www.yaala.org/files/${P}.tar.bz2"
HOMEPAGE="http://www.yaala.org/"
DEPEND="virtual/glibc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
DESCRIPTION="Yet Another Log Analyzer"

src_install(){
	dodir /usr/share/yaala
	cp -dpRx * ${D}usr/share/yaala
}
