# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-gnome/java-gnome-2.14.3.ebuild,v 1.2 2006/12/17 12:43:39 betelgeuse Exp $

inherit eutils

DESCRIPTION="A meta package for all the bindings libraries necessary to write GNOME/GTK applicatons in Java"
HOMEPAGE="http://java-gnome.sourceforge.net/"
DEPEND="!<dev-java/java-gnome-2.8
	~dev-java/glib-java-0.2.6
	~dev-java/cairo-java-1.0.5
	~dev-java/libgtk-java-2.8.7
	~dev-java/libgnome-java-2.12.5
	~dev-java/libglade-java-2.12.6
	~dev-java/libgconf-java-2.12.4
	~dev-java/libvte-java-0.12.1"
# Should also have libeds-java, but doesn't quite work yet.

SLOT="2.14"
LICENSE="as-is"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

pkg_setup() {
	elog "The java-gnome ebuild is a meta package which simply depends on"
	elog "the various ebuilds which make up the java-gnome family, to make it easy"
	elog "to pull them all in."
	elog ""
	elog "You can emerge libglade-java USE=-gnome to avoid the GNOME dependencies."
}
