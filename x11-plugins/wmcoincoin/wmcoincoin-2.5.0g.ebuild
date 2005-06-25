# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcoincoin/wmcoincoin-2.5.0g.ebuild,v 1.1 2005/06/25 13:29:51 pyrania Exp $

IUSE=""

DESCRIPTION="Dockapp for browsing Dacode sites news and board"
HOMEPAGE="http://hules.free.fr/wmcoincoin"
SRC_URI="mirror://sourceforge/dacode/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="virtual/libc
		virtual/x11
		media-libs/imlib2"

src_compile() {
	econf || die "configure failed"
	emake || die "parallel make failed"
}


src_install () {
	einstall || die "make install failed"

	dobin wmcoincoin wmpanpan

	dodoc README AUTHORS Changelog
	docinto examples

	insinto /usr/share/wmcoincoin
	doins options useragents
}
