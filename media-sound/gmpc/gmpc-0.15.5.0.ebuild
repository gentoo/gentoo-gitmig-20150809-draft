# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gmpc/gmpc-0.15.5.0.ebuild,v 1.6 2008/12/11 12:38:57 angelos Exp $

inherit gnome2-utils

DESCRIPTION="A Gnome client for the Music Player Daemon."
HOMEPAGE="http://sarine.nl/gmpc"
SRC_URI="http://download.sarine.nl/${PN}-0.15.5/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="gnome session"

RDEPEND=">=dev-libs/glib-2.10
	dev-perl/XML-Parser
	>=gnome-base/libglade-2.3
	>=media-libs/libmpd-0.15.0
	net-misc/curl
	>=x11-libs/gtk+-2.8
	x11-themes/hicolor-icon-theme
	gnome? ( >=gnome-base/gnome-vfs-2.6 )
	session? ( x11-libs/libSM )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf $(use_enable session sm) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
