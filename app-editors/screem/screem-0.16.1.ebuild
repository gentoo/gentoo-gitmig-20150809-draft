# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/screem/screem-0.16.1.ebuild,v 1.13 2011/03/07 00:18:11 nirbheek Exp $

EAPI="1"

inherit gnome2 autotools

DESCRIPTION="SCREEM is an integrated environment for the creation and maintenance of websites and pages"
HOMEPAGE="http://www.screem.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="doc ssl zlib dbus spell"

RDEPEND=">=dev-libs/glib-2.6.0:2
	>=x11-libs/gtk+-2.6:2
	>=dev-libs/libxml2-2.4.3:2
	>=gnome-base/libglade-2.3:2.0
	>=gnome-base/gconf-2.2:2
	>=gnome-base/gnome-vfs-2.8.3:2
	>=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.6
	gnome-extra/gtkhtml:2
	>=gnome-base/libgnomeprint-2.2:2.2
	>=gnome-base/libgnomeprintui-2.2:2.2
	x11-libs/gtksourceview:1.0
	>=dev-libs/libcroco-0.6.0:0.6
	>=gnome-base/gnome-menus-2.9.2
	dbus? ( >=sys-apps/dbus-0.22 )
	ssl? ( dev-libs/openssl )
	zlib? ( sys-libs/zlib )
	spell? ( >=app-text/enchant-1.1.6 )
	"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.1.1
	>=dev-util/intltool-0.29
	dev-util/pkgconfig
	>=x11-misc/shared-mime-info-0.14
	"

DOCS="AUTHORS BUGS COPYING-DOCS ChangeLog NEWS README TODO"
USE_DESTDIR="1"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-update-mime
		--disable-update-desktop
		--disable-schemas-install
		$(use_with ssl)
		$(use_with zlib)
		$(use_enable dbus)
		$(use_enable spell enchant)"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	gnome2_omf_fix docs/*/Makefile.in docs/omf.make

	# remove deprecation #127486
	sed -i -e 's:$DEPRECATION_FLAGS ::' configure.ac

	eautoreconf
}

pkg_postinst() {
	gnome2_pkg_postinst

	elog
	elog "Run gconftool-2 --shutdown in order to be able to run screem."
	elog "(As a normal user)"
	elog "Otherwise, you will get an error about missing configuration"
	elog "files."
	elog
}
