# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pms/pms-9999.ebuild,v 1.1 2010/05/14 12:42:32 wired Exp $

EAPI=2

inherit autotools git

DESCRIPTION="Practical Music Search: an open source ncurses client for mpd, written in C++"
HOMEPAGE="http://pms.sourceforge.net/"
SRC_URI=""

EGIT_REPO_URI="git://pms.git.sourceforge.net/gitroot/pms/pms"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="regex"

DEPEND="
	sys-libs/ncurses
	dev-libs/glib:2
	regex? ( >=dev-libs/boost-1.36 )
"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable regex) ||
			die "configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"

	dodoc AUTHORS README TODO
}
