# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mencal/mencal-2.3.ebuild,v 1.10 2005/04/01 03:29:40 agriffis Exp $

DESCRIPTION="A calendar that can be used to track menstruation (or other) cycles conveniently"
HOMEPAGE="http://www.kyberdigi.cz/projects/mencal/english.html"
SRC_URI="http://www.kyberdigi.cz/projects/mencal/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc sparc ~mips alpha ~hppa ~amd64 ia64 ~ppc64"
IUSE=""

DEPEND="dev-lang/perl"

src_install() {
	dobin mencal
	dodoc README
}
