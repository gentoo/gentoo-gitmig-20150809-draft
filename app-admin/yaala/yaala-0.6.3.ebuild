# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/yaala/yaala-0.6.3.ebuild,v 1.5 2004/06/24 21:43:40 agriffis Exp $

SRC_URI="http://verplant.org/yaala/${P}.tar.bz2"
HOMEPAGE="http://verplant.org/yaala/"
DEPEND="virtual/glibc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 ppc"
DESCRIPTION="Yet Another Log Analyzer"

src_install(){
	dodir /usr/share/yaala
	cp -dpRx * ${D}usr/share/yaala
}
