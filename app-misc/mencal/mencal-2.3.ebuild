# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mencal/mencal-2.3.ebuild,v 1.1 2003/11/15 09:26:39 seemant Exp $

DESCRIPTION="A calendar that can be used to track menstruation (or other) cycles conveniently"
HOMEPAGE="http://www.kyberdigi.cz/projects/mencal/english.html"
SRC_URI="http://www.kyberdigi.cz/projects/mencal/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm ~amd64 ~ia64"

DEPEND="dev-lang/perl"

src_install () {
	bininto /usr
	dobin mencal

	dodoc README
}
