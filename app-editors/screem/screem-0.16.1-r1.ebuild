# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/screem/screem-0.16.1-r1.ebuild,v 1.2 2011/03/07 00:18:11 nirbheek Exp $

EAPI="2"

inherit autotools eutils gnome2

DESCRIPTION="SCREEM is an integrated environment for the creation and maintenance of websites and pages"
HOMEPAGE="http://www.screem.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="dbus spell nls"

# glib raised to 2.10 for goption
RDEPEND=">=dev-libs/glib-2.10.0:2
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
	dbus? ( >=sys-apps/dbus-1.0.2 )
	spell? ( >=app-text/enchant-1.1.6 )"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.1.1
	>=dev-util/intltool-0.29
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig
	>=x11-misc/shared-mime-info-0.3.14"

DOCS="AUTHORS BUGS COPYING-DOCS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-update-mime
		--disable-update-desktop
		--disable-schemas-install
		$(use_enable nls)
		$(use_enable dbus)
		$(use_enable spell enchant)"
}

src_prepare() {
	gnome2_src_prepare

	# Remove deprecation warnings, bug #127486
	epatch "${FILESDIR}/${P}-deprecated.patch"

	# Make add tag file feature work, bug #256611
	epatch "${FILESDIR}/${P}-add-tag-file.patch"

	# About dialog does not close, bug #256803
	epatch "${FILESDIR}/${P}-fix-about-dialog.patch"

	# Fix error in exit due to old dbus calls, bug #255750
	epatch "${FILESDIR}/${P}-dbus-closing.patch"

	# Port to GOption
	epatch "${FILESDIR}/${P}-goption.patch"

	# Fix tests
	echo "gdl/layout.glade" >> po/POTFILES.in
	echo "src/screem-debug-console.c" >> po/POTFILES.in

	strip-linguas -i "${S}/po"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}

src_install() {
	gnome2_src_install

	# Install translations, bug #256611
	if use nls; then
		cd po
		for loc in ${LINGUAS}; do
			msgfmt ${loc}.po --output-file ${loc}.gmo || die "fail to build ${loc}.po"
			domo ${loc}.gmo || die "domo ${loc}.gmo"
		done
	fi
}
