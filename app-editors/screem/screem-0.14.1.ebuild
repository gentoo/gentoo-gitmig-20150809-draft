# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/screem/screem-0.14.1.ebuild,v 1.2 2006/02/24 00:29:28 allanonjl Exp $

inherit gnome2

DESCRIPTION="SCREEM is an integrated environment of the creation and maintenance of websites and pages"
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
	>=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.6
	=gnome-extra/gtkhtml-2*
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
	echo
	einfo "You must logout of your current gnome session and relogin."
	einfo "This is due to the fact that screem needs gconf to be"
	einfo "restarted and that is the easiest way. "
	einfo "If you do not, you will get an error about screem not"
	einfo "being able to find a required file."
	echo
}

USE_DESTDIR="1"
