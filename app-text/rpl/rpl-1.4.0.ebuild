# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rpl/rpl-1.4.0.ebuild,v 1.17 2005/08/07 12:57:35 hansmi Exp $

DESCRIPTION="rpl is a UN*X text replacement utility. It will replace strings with new strings in multiple text files. It can work recursively"
HOMEPAGE="http://www.laffeycomputer.com/rpl.html"
SRC_URI="http://downloads.laffeycomputer.com/current_builds/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ppc sparc x86"
IUSE=""

DEPEND="virtual/libc"

src_install () {
	dobin src/rpl
	doman man/rpl.1
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
