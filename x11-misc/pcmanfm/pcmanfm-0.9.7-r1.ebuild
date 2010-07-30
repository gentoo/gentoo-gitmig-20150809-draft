# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/pcmanfm/pcmanfm-0.9.7-r1.ebuild,v 1.6 2010/07/30 08:27:53 fauli Exp $

EAPI="2"
inherit eutils fdo-mime

DESCRIPTION="Fast lightweight tabbed filemanager"
HOMEPAGE="http://pcmanfm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="debug hal udev"

RDEPEND=">=dev-libs/glib-2.18:2
	>=x11-libs/gtk+-2.16:2
	hal? ( gnome-base/gnome-mount )
	gnome-base/gvfs[hal?,udev?]
	>=lxde-base/menu-cache-0.3.2
	x11-misc/shared-mime-info
	>=x11-libs/libfm-0.1.11
	lxde-base/lxmenu-data"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	dev-util/pkgconfig
	sys-devel/gettext"

src_configure() {
	strip-linguas -i "${S}/po"
	econf --sysconfdir=/etc $(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS || die
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	elog 'PCmanFM can optionally support the menu://applications/ location.'
	elog 'You should install lxde-base/lxmenu-data for that functionality.'
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
