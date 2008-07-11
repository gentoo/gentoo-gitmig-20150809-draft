# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/xfburn/xfburn-0.3.1.ebuild,v 1.1 2008/07/11 16:49:50 angelos Exp $

EAPI=1

inherit gnome2-utils

DESCRIPTION="GTK+ based CD and DVD burning application"
HOMEPAGE="http://www.xfce.org/projects/xfburn"
SRC_URI="http://www.xfce.org/~pollux/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+dbus debug hal +xfce"

RDEPEND=">=dev-libs/libburn-0.3
	>=dev-libs/libisofs-0.6.2
	>=x11-libs/gtk+-2.10
	>=xfce-base/libxfcegui4-4.4
	>=xfce-extra/exo-0.3
	xfce? ( xfce-base/thunar )
	dbus? ( dev-libs/dbus-glib )
	hal? ( sys-apps/hal )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

src_compile() {
	econf --disable-dependency-tracking \
		$(use_enable xfce thunar-vfs) \
		$(use_enable dbus) \
		$(use_enable hal) \
		$(use_enable debug)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
