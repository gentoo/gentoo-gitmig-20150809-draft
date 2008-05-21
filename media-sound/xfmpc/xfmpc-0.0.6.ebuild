# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xfmpc/xfmpc-0.0.6.ebuild,v 1.2 2008/05/21 15:18:08 armin76 Exp $

inherit fdo-mime

DESCRIPTION="a GTK+ based MPD client focusing on low footprint."
HOMEPAGE="http://goodies.xfce.org/projects/applications/xfmpc"
SRC_URI="http://goodies.xfce.org/releases/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="debug"

RDEPEND=">=media-libs/libmpd-0.15
	>=x11-libs/gtk+-2.12
	>=xfce-base/libxfcegui4-4.4
	>=xfce-base/libxfce4util-4.4"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog IDEAS NEWS README THANKS
}

src_compile() {
	econf --disable-dependency-tracking $(use_enable debug)
	emake || die "emake failed."
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
