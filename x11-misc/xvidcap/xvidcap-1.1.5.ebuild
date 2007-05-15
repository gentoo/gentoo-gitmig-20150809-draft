# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xvidcap/xvidcap-1.1.5.ebuild,v 1.2 2007/05/15 14:48:23 drac Exp $

GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Screen capture utility enabling you to create videos of your desktop for illustration or documentation purposes."
HOMEPAGE="http://xvidcap.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libXmu
	x11-libs/libX11
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	>=x11-libs/gtk+-2.4
	media-sound/lame"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	app-text/scrollkeeper
	app-text/gnome-doc-utils
	sys-devel/gettext"

src_install() {
	emake DESTDIR="${D}" install || "emake install failed."

	# Almost like bug #58322 but directory name changed.
	rm -rf "${D}"/usr/share/doc/${PN}
	dodoc AUTHORS ChangeLog NEWS README TODO.tasks
}
