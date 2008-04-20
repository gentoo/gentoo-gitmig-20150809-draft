# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gnome-mplayer/gnome-mplayer-0.6.0.ebuild,v 1.2 2008/04/20 16:24:37 maekke Exp $

GCONF_DEBUG=no

inherit gnome2

DESCRIPTION="MPlayer GUI for GNOME Desktop Environment"
HOMEPAGE="http://dekorte.homeip.net/download/gnome-mplayer"
SRC_URI="http://dekorte.homeip.net/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.12
	>=dev-libs/glib-2.14
	>=dev-libs/dbus-glib-0.7
	>=gnome-base/gconf-2
	media-video/mplayer"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ChangeLog README DOCS/tech/*.txt
	rm -rf "${D}"/usr/share/doc/${PN}
}
