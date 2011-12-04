# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/glurp/glurp-0.12.3.ebuild,v 1.3 2011/12/04 14:57:02 hwoarang Exp $

EAPI=4
inherit eutils

DESCRIPTION="Glurp is a GTK2 based graphical client for the Music Player Daemon"
HOMEPAGE="http://sourceforge.net/projects/glurp/"
SRC_URI="mirror://sourceforge/glurp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="debug"

RDEPEND="x11-libs/gtk+:2
	>=dev-libs/glib-2.4:2
	x11-libs/gdk-pixbuf:2
	x11-libs/pango
	>=media-libs/libmpd-0.17"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( AUTHORS ChangeLog )

src_configure() {
	econf \
		$(use_enable debug)
}

src_install() {
	default
	doicon "${FILESDIR}"/${PN}.svg
	make_desktop_entry glurp Glurp glurp AudioVideo
}
