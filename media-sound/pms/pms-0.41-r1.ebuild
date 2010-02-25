# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pms/pms-0.41-r1.ebuild,v 1.1 2010/02/25 21:33:00 wired Exp $

EAPI=2

inherit base

DESCRIPTION="Practical Music Search: an open source ncurses client for mpd, written in C++"
HOMEPAGE="http://pms.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="regex"

DEPEND="
	sys-libs/ncurses
	dev-libs/glib:2
	regex? ( >=dev-libs/boost-1.36 )
"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"

	dodoc AUTHORS README TODO
}
