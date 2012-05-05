# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmudmount/wmudmount-1.8.ebuild,v 1.5 2012/05/05 05:12:01 jdhore Exp $

EAPI=2
inherit flag-o-matic gnome2-utils

DESCRIPTION="A filesystem mounter that uses udisks to handle notification and mounting"
HOMEPAGE="http://sourceforge.net/projects/wmudmount/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome-keyring libnotify"

RDEPEND=">=x11-libs/gtk+-2.18:2
	dev-libs/dbus-glib
	sys-fs/udisks:0
	gnome-keyring? ( gnome-base/libgnome-keyring )
	libnotify? ( x11-libs/libnotify )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	|| ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch
}

src_configure() {
	has_version ">=x11-libs/libnotify-0.7" && append-cppflags -DHAVE_LIBNOTIFY_07

	econf \
		--disable-dependency-tracking \
		$(use_with libnotify) \
		$(use_with gnome-keyring)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog
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
