# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnotime/gnotime-2.3.0-r3.ebuild,v 1.5 2011/01/05 16:38:21 pacho Exp $

EAPI="3"
GCONF_DEBUG="yes"

inherit autotools eutils gnome2

DESCRIPTION="Utility to track time spent on activities"
HOMEPAGE="http://gttr.sourceforge.net/"
SRC_URI="mirror://sourceforge/gttr/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 sparc x86"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2.10
	>=dev-libs/glib-2.14
	>=gnome-base/libgnome-2.0
	>=gnome-base/libgnomeui-2.0.3
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libglade-2.0
	>=gnome-extra/gtkhtml-3.14.3:3.14
	>=gnome-base/gconf-2.0
	dev-libs/libxml2
	>=dev-libs/dbus-glib-0.74
	dev-scheme/guile[deprecated]
	dev-libs/qof:0
	x11-libs/libXScrnSaver
	x11-libs/pango"

DEPEND="${RDEPEND}
	x11-proto/scrnsaverproto
	dev-util/pkgconfig
	dev-util/intltool
	>=app-text/scrollkeeper-0.3.11
	doc? ( ~app-text/docbook-xml-dtd-4.2 )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

src_prepare() {
	# man generation needs docbook-xml-dtd
	use doc || sed -i -e "s/SUBDIRS = man/SUBDIRS = /" doc/C/Makefile.{in,am}

	# Fix column descriptions, bug #222325
	epatch "${FILESDIR}/${P}-fix-columns.patch"

	# Fix typo in PKG_CHECK_MODULES, bug #298193
	epatch "${FILESDIR}/${P}-libgnomeui-typo.patch"

	# Make it 64bit safe, bug 231986
	epatch "${FILESDIR}"/${P}-missing-includes.patch

	intltoolize --automake --copy --force || die "intltoolize failed"
	eautoreconf
}
