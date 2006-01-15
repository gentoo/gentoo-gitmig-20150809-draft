# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/scmxx/scmxx-0.8.2.ebuild,v 1.2 2006/01/15 11:10:23 mrness Exp $

DESCRIPTION="Exchange data with Siemens phones"
HOMEPAGE="http://www.hendrik-sattler.de/scmxx/"
SRC_URI="mirror://sourceforge/scmxx/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	exeinto /usr/lib/scmxx
	doexe contrib/*

	doman docs/scmxx.*.1

	rm docs/README_WIN32.txt
	dodoc AUTHORS BUGS CHANGELOG README TODO docs/*.txt
}
