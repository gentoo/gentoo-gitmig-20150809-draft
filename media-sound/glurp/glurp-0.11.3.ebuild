# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/glurp/glurp-0.11.3.ebuild,v 1.4 2004/11/23 05:13:04 eradicator Exp $

IUSE="debug"

DESCRIPTION="Glurp is a GTK2 based graphical client for the Music Player Daemon"
HOMEPAGE="http://sourceforge.net/projects/glurp/"
SRC_URI="mirror://sourceforge/glurp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"

DEPEND=">=x11-libs/gtk+-2.4.0
	>=gnome-base/libglade-2.3.6"

src_compile() {
	econf $(use_enable debug) || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog
}
