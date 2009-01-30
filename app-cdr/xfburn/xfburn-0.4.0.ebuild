# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/xfburn/xfburn-0.4.0.ebuild,v 1.3 2009/01/30 17:11:59 angelos Exp $

EAPI=1

inherit gnome2-utils

DESCRIPTION="GTK+ based CD and DVD burning application"
HOMEPAGE="http://www.xfce.org/projects/xfburn"
SRC_URI="http://goodies.xfce.org/releases/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="+dbus debug gstreamer hal +xfce"

RDEPEND=">=dev-libs/libburn-0.4.2
	>=dev-libs/libisofs-0.6.2
	>=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfcegui4-4.4
	>=xfce-extra/exo-0.3
	dbus? ( dev-libs/dbus-glib )
	gstreamer? ( media-libs/gstreamer 
		>=media-libs/gst-plugins-base-0.10.20 )
	hal? ( sys-apps/hal )
	xfce? ( xfce-base/thunar )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

src_compile() {
	econf --disable-dependency-tracking \
		$(use_enable dbus) \
		$(use_enable debug) \
		$(use_enable gstreamer) \
		$(use_enable hal) \
		$(use_enable xfce thunar-vfs)
	emake || die "emake failed"
}

pkg_preinst() {
	gnome2_icon_savelist
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
