# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rpl/rpl-1.4.0.ebuild,v 1.8 2004/02/22 20:06:31 agriffis Exp $

DESCRIPTION="rpl is a UN*X text replacement utility. It will replace strings with new strings in multiple text files. It can work recursively"
HOMEPAGE="http://www.laffeycomputer.com/rpl.html"
SRC_URI="http://downloads.laffeycomputer.com/current_builds/${P}.tar.gz"
S=${WORKDIR}/${P}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND="virtual/glibc"

src_install () {
	dobin src/rpl
	doman man/rpl.1
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
