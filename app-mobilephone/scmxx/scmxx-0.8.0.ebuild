# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/scmxx/scmxx-0.8.0.ebuild,v 1.1 2005/07/21 20:44:34 mrness Exp $

DESCRIPTION="Exchange data with Siemens phones"
HOMEPAGE="http://www.hendrik-sattler.de/scmxx/"
SRC_URI="mirror://sourceforge/scmxx/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	make DESTDIR=${D} install || die

	exeinto /usr/lib/scmxx
	doexe contrib/*

	doman docs/scmxx.*.1

	rm docs/README_WIN32.txt
	dodoc AUTHORS BUGS CHANGELOG INSTALL README TODO docs/*.txt
}
