# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/xfburn/xfburn-0.3.2.ebuild,v 1.2 2008/09/21 21:43:08 angelos Exp $

EAPI=1

inherit eutils gnome2-utils

DESCRIPTION="GTK+ based CD and DVD burning application"
HOMEPAGE="http://www.xfce.org/projects/xfburn"
SRC_URI="http://goodies.xfce.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
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

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-disable-hal.patch
}

src_compile() {
	econf --disable-dependency-tracking \
		$(use_enable xfce thunar-vfs) \
		$(use_enable dbus) \
		$(use_enable hal) \
		$(use_enable debug)
	emake || die "emake failed."
}

pkg_preinst() {
	gnome2_icon_savelist
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
