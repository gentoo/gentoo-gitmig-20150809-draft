# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/htop/htop-0.6.2.ebuild,v 1.7 2006/08/10 20:07:07 jer Exp $

inherit debug flag-o-matic

DESCRIPTION="interactive process viewer"
HOMEPAGE="http://htop.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~ia64 ppc ~ppc64 sparc x86 ~x86-fbsd"
DEPEND="sys-libs/ncurses"

src_compile() {
	useq debug && append-flags -O -ggdb -DDEBUG
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog TODO
}
