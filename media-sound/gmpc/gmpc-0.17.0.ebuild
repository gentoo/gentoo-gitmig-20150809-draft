# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gmpc/gmpc-0.17.0.ebuild,v 1.2 2008/12/29 13:53:01 angelos Exp $

EAPI=1

inherit gnome2-utils

DESCRIPTION="A GTK+2 client for the Music Player Daemon"
HOMEPAGE="http://gmpcwiki.sarine.nl/index.php/GMPC"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="session"

RDEPEND=">=dev-libs/glib-2.10:2
	dev-perl/XML-Parser
	>=gnome-base/libglade-2.3
	>=media-libs/libmpd-0.17
	net-misc/curl
	>=x11-libs/gtk+-2.12:2
	x11-libs/libsexy
	session? ( x11-libs/libSM )"
DEPEND="${RDEPEND}
	dev-util/gob
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

src_compile() {
	econf \
		$(use_enable session sm) \
		--enable-system-libsexy
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
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
