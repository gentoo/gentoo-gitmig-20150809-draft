# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/qpxtool/qpxtool-0.6.1.ebuild,v 1.3 2007/10/08 20:22:39 coldwind Exp $

inherit kde-functions qt3 multilib eutils

DESCRIPTION="cd/dvd quality checker for a variety of drives"
HOMEPAGE="http://qpxtool.sourceforge.net/"
SRC_URI="mirror://sourceforge/qpxtool/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=x11-libs/qt-3*"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^PREFIX/s:/usr/local:/usr:' \
		-e "/^LIBDIR/s:/lib:/$(get_libdir):" \
		Makefile || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	newicon qpxtool-gui/img/q.xpm ${PN}.xpm
	make_desktop_entry ${PN} Qpxtool ${PN}.xpm "Utility;Qt;DiscBurning"
	dodoc AUTHORS ChangeLog README TODO
}
