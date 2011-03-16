# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-3.6.7.ebuild,v 1.11 2011/03/16 10:23:49 nirbheek Exp $

EAPI="2"

inherit gnome2

MY_PN="glade3"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="GNOME GUI Builder"
HOMEPAGE="http://glade.gnome.org/"
SRC_URI="mirror://gnome/sources/${MY_PN}/${PVP[0]}.${PVP[1]}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="doc gnome python"

RDEPEND=">=dev-libs/glib-2.8.0:2
	>=x11-libs/gtk+-2.14.0:2
	>=dev-libs/libxml2-2.4:2
	gnome?	(
		>=gnome-base/libgnomeui-2.0
		>=gnome-base/libbonoboui-2.0 )
	python? ( >=dev-python/pygtk-2.10.0:2 )
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.19
	sys-devel/gettext
	app-text/scrollkeeper
	>=app-text/gnome-doc-utils-0.9
	app-text/docbook-xml-dtd:4.1.2
	doc? ( >=dev-util/gtk-doc-1.9 )
"

S="${WORKDIR}/${MY_P}"
DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		--enable-libtool-lock
		--disable-scrollkeeper
		$(use_enable gnome)
		$(use_enable python)"
}

src_prepare() {
	gnome2_src_prepare

	# Fix intltoolize broken file, see upstream #577133
	sed "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" -i po/Makefile.in.in \
		|| die "sed 1 failed"
}
