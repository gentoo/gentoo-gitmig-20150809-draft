# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mencal/mencal-2.3.ebuild,v 1.3 2004/05/04 17:13:52 kloeri Exp $

DESCRIPTION="A calendar that can be used to track menstruation (or other) cycles conveniently"
HOMEPAGE="http://www.kyberdigi.cz/projects/mencal/english.html"
SRC_URI="http://www.kyberdigi.cz/projects/mencal/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc alpha ~hppa ~mips ~amd64 ~ia64"

DEPEND="dev-lang/perl"

src_install () {
	bininto /usr
	dobin mencal

	dodoc README
}
