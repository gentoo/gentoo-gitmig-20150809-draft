# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/qlife/qlife-0.7.ebuild,v 1.2 2004/10/17 10:00:54 dholm Exp $

inherit kde
need-qt 3

DESCRIPTION="Simulates the classical Game of Life invented by John Conway."
HOMEPAGE="http://personal.inet.fi/koti/rkauppila/projects/life/"
SRC_URI="http://freshmeat.net/redir/qlife/50265/url_tgz/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

src_compile() {
	qmake || die "qmake failed"
	emake || die "emake failed"
}

src_install() {
	dobin qlife || die "dobin failed"
	insinto /usr/share/qlife
	doins patterns/* || die "doins failed"
	dodoc README ChangeLog Todo About
}
