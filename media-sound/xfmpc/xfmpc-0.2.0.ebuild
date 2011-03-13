# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xfmpc/xfmpc-0.2.0.ebuild,v 1.5 2011/03/13 12:50:51 armin76 Exp $

EAPI=2
inherit fdo-mime

DESCRIPTION="a GTK+ based MPD client focusing on low footprint."
HOMEPAGE="http://goodies.xfce.org/projects/applications/xfmpc"
SRC_URI="mirror://xfce/src/apps/${PN}/0.2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND=">=media-libs/libmpd-0.15
	>=x11-libs/gtk+-2.12:2
	x11-themes/hicolor-icon-theme
	>=xfce-base/libxfcegui4-4.4
	>=xfce-base/libxfce4util-4.4"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog IDEAS NEWS README THANKS
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
