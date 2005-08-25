# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/screem/screem-0.14.3.ebuild,v 1.1 2005/08/25 18:52:20 allanonjl Exp $

inherit gnome2

DESCRIPTION="SCREEM (Site CReating and Editing EnvironmenMent) is an
integrated environment of the creation and maintenance of websites and
pages"
HOMEPAGE="http://www.screem.org/"
SRC_URI="mirror://sourceforge/screem/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE="doc ssl zlib dbus"

RDEPEND=">=dev-libs/glib-2.5.6
	>=x11-libs/gtk+-2.6
	>=dev-libs/libxml2-2.4.3
	>=gnome-base/libglade-2.3
	>=gnome-base/gconf-2.2
	>=gnome-base/gnome-vfs-2.8.3
	media-libs/gdk-pixbuf
	>=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.6
	=gnome-extra/libgtkhtml-2*
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	>=x11-libs/gtksourceview-1.1.90
	>=dev-libs/libcroco-0.6.0
	dbus? ( >=sys-apps/dbus-0.22 )
	ssl? ( dev-libs/openssl )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.1.1
	>=dev-util/intltool-0.29
	dev-util/pkgconfig
	>=x11-misc/shared-mime-info-0.14"

G2CONF="${G2CONF} --disable-update-mime --disable-update-desktop \
	--disable-schemas-install $(use_with ssl) $(use_with zlib) \
	$(use_enable dbus)"

DOCS="ABOUT-NLS AUTHORS BUGS COPYING COPYING-DOCS ChangeLog INSTALL NEWS README TODO"

src_install() {
	# fix scrollkeeper 
	gnome2_src_install scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/
}

pkg_postinst() {
	gnome2_pkg_postinst

	echo
	einfo "Run gconftool-2 --shutdown in order to be able to run screem."
	einfo "(As a normal user)"
	einfo "Otherwise, you will get an error about missing configuration"
	einfo "files."
	echo
}

USE_DESTDIR="1"
