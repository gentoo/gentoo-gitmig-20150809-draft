# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-lt/ispell-lt-1.2.1.ebuild,v 1.2 2008/11/01 12:15:45 pva Exp $

inherit multilib

DESCRIPTION="Lithuanian dictionary for ispell"
HOMEPAGE="http://files.akl.lt/ispell-lt/"
SRC_URI="http://files.akl.lt/ispell-lt/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND="app-text/ispell
	dev-lang/python"

src_compile() {
	emake || die
}

src_install() {
	insinto /usr/$(get_libdir)/ispell
	doins lietuviu.hash lietuviu.aff || die
	dodoc README THANKS ChangeLog
}
