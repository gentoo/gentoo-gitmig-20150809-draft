# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/scmxx/scmxx-0.6.4.ebuild,v 1.5 2004/06/28 04:12:14 vapier Exp $

DESCRIPTION="Exchange data with Siemens phones"
HOMEPAGE="http://www.hendrik-sattler.de/scmxx/"
SRC_URI="mirror://sourceforge/scmxx/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	make DESTDIR=${D} install || die
	exeinto /usr/lib/scmxx
	doexe contrib/*
	dodoc AUTHORS BUGS CHANGELOG INSTALL README TODO VERSION docs/*.txt
	newdoc docs/README README.doc
}
