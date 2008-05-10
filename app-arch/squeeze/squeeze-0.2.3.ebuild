# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/squeeze/squeeze-0.2.3.ebuild,v 1.1 2008/05/10 02:36:46 drac Exp $

EAPI=1

inherit eutils fdo-mime gnome2-utils

DESCRIPTION="Squeeze is a GTK+ based and advanced archive manager for Xfce4 Desktop Environment."
HOMEPAGE="http://squeeze.xfce.org"
SRC_URI="http://${PN}.xfce.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
# -sparc and -hppa: http://bugzilla.xfce.org/show_bug.cgi?id=3162
KEYWORDS="~alpha ~amd64 -hppa ~ia64 ~ppc ~ppc64 -sparc ~x86 ~x86-fbsd"
IUSE="debug +pathbar +toolbar"

RDEPEND="x11-libs/gtk+:2
	dev-libs/dbus-glib
	>=xfce-base/libxfce4util-4.4
	xfce-base/thunar"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

src_compile() {
	econf --disable-gtk-doc --disable-dependency-tracking \
		$(use_enable pathbar) $(use_enable toolbar) \
		$(use_enable debug)

	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS TODO
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
