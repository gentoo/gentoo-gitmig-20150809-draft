# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/yaala/yaala-0.6.3.ebuild,v 1.6 2004/06/25 23:09:00 vapier Exp $

DESCRIPTION="Yet Another Log Analyzer"
HOMEPAGE="http://verplant.org/yaala/"
SRC_URI="http://verplant.org/yaala/yaala-0.4.2.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	dodir /usr/share/yaala
	cp -dpRx * ${D}/usr/share/yaala/
}
