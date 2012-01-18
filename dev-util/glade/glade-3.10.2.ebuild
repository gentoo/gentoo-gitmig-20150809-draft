# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-3.10.2.ebuild,v 1.5 2012/01/18 20:32:43 maekke Exp $

EAPI="4"
GNOME2_LA_PUNT="yes"
GCONF_DEBUG="yes"

inherit gnome2 versionator

DESCRIPTION="GNOME GUI Builder"
HOMEPAGE="http://glade.gnome.org/"

LICENSE="GPL-2"
SLOT="3.10"
KEYWORDS="~alpha amd64 arm ~ia64 ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE="doc +introspection python"

RDEPEND=">=x11-libs/gtk+-3.0.2:3
	>=dev-libs/libxml2-2.4.0:2
	introspection? ( >=dev-libs/gobject-introspection-0.10.1 )
	python? ( >=dev-python/pygobject-2.27.0:2 )
"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/intltool-0.41.0
	>=dev-util/pkgconfig-0.19
	>=sys-devel/gettext-0.17
	>=app-text/gnome-doc-utils-0.18
	app-text/docbook-xml-dtd:4.1.2
	doc? ( >=dev-util/gtk-doc-1.13 )
"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="${G2CONF}
		--disable-maintainer-mode
		--disable-static
		--enable-libtool-lock
		--disable-scrollkeeper
		$(use_enable introspection)
		$(use_enable python)"
}

src_prepare() {
	# to avoid file collision with glade:3, rename GNOME help module from
	# glade to glade-3.10, and gladeui documentation from gladeui to gladeui-2
	local i
	sed -e 's:DOC_MODULE = glade:DOC_MODULE = glade-3.10:' -i help/Makefile.in \
		|| die "sed of help/Makefile.in failed"
	sed -e 's:/glade.xml:/glade-3.10.xml:g' -i help/*/*.po \
		|| die "sed of help .po files failed"
	for i in help/*/glade.xml ; do
		mv ${i} ${i/glade/glade-3.10} || die "mv ${i} failed"
	done
	sed -e 's:DOC_MODULE = gladeui:DOC_MODULE = gladeui-2:' -i doc/Makefile.in \
		|| die "sed of doc/Makefile.in failed"
	for i in doc/gladeui-* doc/gladeui.* ; do
		mv ${i} ${i/gladeui/gladeui-2} || die "mv ${i} failed"
	done

	gnome2_src_prepare
}

src_install() {
	# modify Name in .desktop file to avoid confusion with other slots
	sed -e 's:^\(Name.*=Glade\):\1 '$(get_version_component_range 1-2): \
		-i data/glade.desktop || die "sed of data/glade.desktop failed"
	gnome2_src_install
}
