# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/convmv/convmv-1.05.ebuild,v 1.9 2005/04/01 03:41:52 agriffis Exp $

DESCRIPTION="convert filenames to utf8 or any other charset"
HOMEPAGE="http://j3e.de/linux/${PN}"
SRC_URI="http://j3e.de/linux/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~hppa alpha ~mips ~sparc ia64 ~amd64 ~ppc"
IUSE=""

DEPEND="dev-lang/perl"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	einstall DESTDIR=${D} PREFIX=/usr || die "einstall failed"
	dodoc CREDITS Changes GPL2 TODO VERSION testsuite.tar
}
