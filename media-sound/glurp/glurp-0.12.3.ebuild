# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/glurp/glurp-0.12.3.ebuild,v 1.1 2011/04/19 19:15:30 aballier Exp $

EAPI=2
inherit eutils

DESCRIPTION="Glurp is a GTK2 based graphical client for the Music Player Daemon"
HOMEPAGE="http://sourceforge.net/projects/glurp/"
SRC_URI="mirror://sourceforge/glurp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2:2
	>=media-libs/libmpd-0.17"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog || die
	doicon "${FILESDIR}"/${PN}.svg || die
	make_desktop_entry glurp Glurp glurp AudioVideo
}
