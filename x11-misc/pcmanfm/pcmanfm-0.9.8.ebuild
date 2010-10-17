# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/pcmanfm/pcmanfm-0.9.8.ebuild,v 1.1 2010/10/17 11:02:33 hwoarang Exp $

EAPI="2"

inherit autotools eutils fdo-mime

DESCRIPTION="Fast lightweight tabbed filemanager"
HOMEPAGE="http://pcmanfm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug gnome hal udev"

RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:2
	lxde-base/menu-cache
	x11-misc/shared-mime-info
	>=x11-libs/libfm-0.1.14[gnome=,hal=,udev=]
	virtual/eject"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	# add missing files to traslation file. Fixes tests
	for i in about.ui autorun.ui desktop-pref.ui pref.ui; do
		echo "data/ui/${i}" >> po/POTFILES.in
	done
	eautoreconf
	einfo "Running intltoolize ..."
	intltoolize --force --copy --automake || die
	strip-linguas -i "${S}/po"
}

src_configure() {
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
	elog 'You should install lxde-base/lxmenu-data for that	functionality.'
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
