# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgtop/libgtop-2.14.9.ebuild,v 1.7 2007/08/25 14:24:54 vapier Exp $

inherit gnome2 eutils

DESCRIPTION="A library that provides top functionality to applications"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm ~hppa ia64 ppc ~ppc64 sh sparc x86 ~x86-fbsd"
IUSE="gdbm X"

RDEPEND=">=dev-libs/glib-2.6
	gdbm? ( sys-libs/gdbm )
	dev-libs/popt"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} $(use_with gdbm libgtop-inodedb) $(use_with X x)"
}
