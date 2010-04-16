# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/hatools/hatools-2.00.ebuild,v 1.3 2010/04/16 19:07:30 grobian Exp $

DESCRIPTION="hatools: High availability environment tools for shell scripting
(halockrun and hatimerun)"
HOMEPAGE="http://www.fatalmind.com/software/hatools/"
SRC_URI="http://www.fatalmind.com/software/hatools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~mips ~ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS NEWS ChangeLog
}
