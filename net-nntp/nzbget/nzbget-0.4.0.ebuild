# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/nzbget/nzbget-0.4.0.ebuild,v 1.1 2008/05/30 22:00:35 swegener Exp $

EAPI="1"

DESCRIPTION="A command-line based binary newsgrabber supporting .nzb files"
HOMEPAGE="http://nzbget.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug ncurses parcheck"

DEPEND="dev-libs/libxml2
	parcheck? (
		app-arch/libpar2
		dev-libs/libsigc++:2
	)
	curses? ( sys-libs/ncurses )"
RDEPEND="${DEPEND}"

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable ncurses curses) \
		$(use_enable parcheck) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog README nzbget.conf.example || die "dodoc failed"
}
