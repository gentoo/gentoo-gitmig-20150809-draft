# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-2.12.2-r1.ebuild,v 1.9 2012/05/04 17:51:44 jdhore Exp $

EAPI="2"

inherit gnome2

DESCRIPTION="A user interface builder for the GTK+ toolkit and GNOME"
HOMEPAGE="http://glade.gnome.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE="accessibility gnome"

RDEPEND=">=dev-libs/libxml2-2.4.1:2
		 >=x11-libs/gtk+-2.8:2
		 gnome? (
					>=gnome-base/libgnomeui-2.9
					>=gnome-base/libgnomecanvas-2
					>=gnome-base/libbonoboui-2
					accessibility? ( gnome-extra/libgail-gnome )
				)"
DEPEND="${RDEPEND}
		virtual/pkgconfig
		sys-devel/gettext
		>=app-text/scrollkeeper-0.1.4
		>=dev-util/intltool-0.28"

DOCS="AUTHORS ChangeLog FAQ NEWS README TODO"

pkg_setup() {
	G2CONF="$(use_enable gnome)"
}
