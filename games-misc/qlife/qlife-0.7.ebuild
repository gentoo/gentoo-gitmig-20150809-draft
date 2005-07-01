# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/qlife/qlife-0.7.ebuild,v 1.4 2005/07/01 15:03:34 caleb Exp $

inherit kde
need-qt 3

DESCRIPTION="Simulates the classical Game of Life invented by John Conway"
HOMEPAGE="http://personal.inet.fi/koti/rkauppila/projects/life/"
SRC_URI="http://freshmeat.net/redir/qlife/50265/url_tgz/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

src_compile() {
	${QTDIR}/bin/qmake || die "qmake failed"
	emake || die "emake failed"
}

src_install() {
	dobin qlife || die "dobin failed"
	insinto /usr/share/qlife
	doins patterns/* || die "doins failed"
	dodoc README ChangeLog Todo About
}
