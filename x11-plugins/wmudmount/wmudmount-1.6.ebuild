# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmudmount/wmudmount-1.6.ebuild,v 1.1 2010/06/29 09:34:52 voyageur Exp $

EAPI=2
inherit gnome2-utils

DESCRIPTION="A filesystem mounter that uses udisks to handle notification and mounting"
HOMEPAGE="http://sourceforge.net/projects/wmudmount/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome-keyring libnotify"

RDEPEND=">=x11-libs/gtk+-2.18:2
	dev-libs/dbus-glib
	sys-fs/udisks
	gnome-keyring? ( gnome-base/gnome-keyring )
	libnotify? ( x11-libs/libnotify )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
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
