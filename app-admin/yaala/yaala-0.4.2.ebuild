# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/yaala/yaala-0.4.2.ebuild,v 1.10 2004/11/22 22:42:34 swegener Exp $

DESCRIPTION="Yet Another Log Analyzer"
HOMEPAGE="http://yaala.org/"
SRC_URI="http://yaala.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	dodir /usr/share/yaala
	cp -dpRx * ${D}/usr/share/yaala/
}
