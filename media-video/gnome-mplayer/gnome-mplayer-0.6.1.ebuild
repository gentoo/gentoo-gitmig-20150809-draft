# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gnome-mplayer/gnome-mplayer-0.6.1.ebuild,v 1.1 2008/04/20 13:27:19 drac Exp $

GCONF_DEBUG=no

inherit gnome2

DESCRIPTION="MPlayer GUI for GNOME Desktop Environment"
HOMEPAGE="http://code.google.com/p/gnome-mplayer"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.12
	>=dev-libs/glib-2.14
	dev-libs/dbus-glib
	>=gnome-base/gconf-2
	media-video/mplayer"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_install() {
	addpredict /etc/gconf/gconf.xml.defaults/.testing.writeability
	emake DESTDIR="${D}" install || die "emake install failed."
	# Install documentation by hand because it tries to install 0 byte size
	# files, with COPYING and INSTALL.
	rm -rf "${D}"/usr/share/doc/${PN}
	dodoc ChangeLog README DOCS/{.,tech}/*.txt
}
