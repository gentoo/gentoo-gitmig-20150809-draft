# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany/epiphany-1.4.6.ebuild,v 1.4 2005/03/23 16:19:45 seemant Exp $

inherit eutils gnome2

DESCRIPTION="GNOME webbrowser based on the mozilla rendering engine"
HOMEPAGE="http://www.gnome.org/projects/epiphany/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64 ia64 hppa"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.4.1
	>=x11-libs/pango-1.6
	>=x11-libs/gtk+-2.4
	>=gnome-base/gconf-1.2
	>=dev-libs/libxml2-2.6.6
	>=gnome-base/libgnomeui-2.6.0
	>=gnome-base/libglade-2.3.1
	>=gnome-base/libbonoboui-2.2
	>=gnome-base/orbit-2
	>=gnome-base/gnome-vfs-2.3.1
	>=www-client/mozilla-1.7.3
	gnome? ( >=gnome-base/nautilus-2.5 )"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	dev-util/pkgconfig
	>=dev-util/intltool-0.29
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README TODO"

MAKEOPTS="${MAKEOPTS} -j1"

pkg_setup () {

	if [ ! -f ${ROOT}/usr/lib/mozilla/components/libwidget_gtk2.so ]
	then
		eerror "you need mozilla-1.7.3+ compiled against gtk+-2"
		eerror "export USE=\"gtk2\" ;emerge mozilla -p "
		die "Need Mozilla compiled with gtk+-2.0!"
	fi

}

src_unpack() {

	unpack ${A}

	# Fix include paths for our mozilla
	epatch ${FILESDIR}/${P}-fix_includes.patch
	# Fix compilation/API breakage with mozilla 1.7.5.
	# See bug #74972 ,<obz@gentoo.org>
	epatch ${FILESDIR}/${P}-moz-nsiurip.patch

}
