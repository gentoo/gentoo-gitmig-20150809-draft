# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libchamplain/libchamplain-0.6.0.ebuild,v 1.11 2011/06/15 08:43:37 jlec Exp $

EAPI="3"

PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"

inherit gnome2 python

DESCRIPTION="Clutter based world map renderer"
HOMEPAGE="http://blog.pierlux.com/projects/libchamplain/en/"

LICENSE="LGPL-2"
SLOT="0.6"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc gtk html +introspection python"

RDEPEND="
	dev-libs/glib:2
	>=x11-libs/cairo-1.4
	net-libs/libsoup-gnome:2.4
	media-libs/clutter:1.0[introspection?]
	media-libs/memphis
	dev-db/sqlite:3
	gtk? (
		x11-libs/gtk+:2[introspection?]
		media-libs/memphis:0.2
		>=media-libs/clutter-gtk-0.10:0.10 )
	python? (
		media-libs/pymemphis
		dev-python/pyclutter
		dev-python/pyclutter-gtk )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.9 )
	introspection? ( >=dev-libs/gobject-introspection-0.6.3 )"

RESTRICT_PYTHON_ABIS="3.*"

DOCS="AUTHORS ChangeLog NEWS README"

G2CONF="${G2CONF}
	--disable-static
	--enable-memphis
	--with-html-dir="${EPREFIX}/usr/share/doc/${PF}/html"
	$(use_enable debug)
	$(use_enable gtk)
	$(use_enable html gtk-doc-html)
	$(use_enable introspection)
	$(use_enable python)"

src_prepare() {
	gnome2_src_prepare
	sed 's:bindings::g' -i Makefile.in || die
}

src_compile() {
	gnome2_src_compile
	if use python; then
		python_copy_sources bindings
		building() {
			emake \
			PYTHON_INCLUDES="-I$(python_get_includedir)" \
			pythondir="$(python_get_sitedir)" \
			pyexecdir="$(python_get_sitedir)"
		}
		python_execute_function -s --source-dir bindings building
	fi
}

src_install() {
	gnome2_src_install
	if use python; then
		installation() {
			emake DESTDIR="${ED}" \
			pythondir="$(python_get_sitedir)" \
			pyexecdir="$(python_get_sitedir)" \
			install
	}
	python_execute_function -s --source-dir bindings installation
	python_clean_installation_image
	fi
}
