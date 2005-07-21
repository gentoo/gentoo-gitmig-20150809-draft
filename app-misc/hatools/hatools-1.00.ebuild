# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/hatools/hatools-1.00.ebuild,v 1.3 2005/07/21 17:19:56 dholm Exp $

DESCRIPTION="hatools: High availability environment tools for shell scripting
(halockrun and hatimerun)"
HOMEPAGE="http://www.fatalmind.com/software/hatools/"
SRC_URI="http://www.fatalmind.com/software/hatools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="mips ~ppc sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	make DESTDIR="${D}" install || die "oops, install not happy"
	dodoc README AUTHORS NEWS ChangeLog
}
