# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gedit-plugins/gedit-plugins-3.2.1-r1.ebuild,v 1.3 2012/05/02 01:36:15 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes" # plugins are dlopened
PYTHON_DEPEND="python? 2:2.6"
PYTHON_USE_WITH="xml"
PYTHON_USE_WITH_OPT="python"

inherit gnome2 multilib python eutils

DESCRIPTION="Offical plugins for gedit"
HOMEPAGE="http://live.gnome.org/GeditPlugins"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"

IUSE_plugins="charmap synctex terminal"
IUSE="+python ${IUSE_plugins}"

RDEPEND=">=app-editors/gedit-3.2.0[python?]
	>=dev-libs/glib-2.26.0:2
	>=dev-libs/libpeas-0.7.3[gtk,python?]
	>=x11-libs/gtk+-3.0.0:3
	>=x11-libs/gtksourceview-3.0.0:3.0
	python? (
		>=app-editors/gedit-3.0.0[introspection]
		dev-python/pycairo
		|| (
			dev-python/pygobject:2[cairo,introspection]
			dev-python/pygobject:3[cairo] )
		>=x11-libs/gtk+-3.0.0:3[introspection]
		>=x11-libs/gtksourceview-3.0.0:3.0[introspection]
		x11-libs/pango[introspection]
		x11-libs/gdk-pixbuf:2[introspection]
	)
	charmap? ( >=gnome-extra/gucharmap-3.0.0:2.90[introspection] )
	synctex? ( >=dev-python/dbus-python-0.82 )
	terminal? ( x11-libs/vte:2.90[introspection] )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40.0
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	# DEFAULT_PLUGINS from configure.ac
	local myplugins="bookmarks,drawspaces,wordcompletion,taglist"

	# python plugins with no extra dependencies beyond what USE=python brings
	use python && myplugins="${myplugins},bracketcompletion,codecomment,colorpicker,commander,joinlines,multiedit,textsize,sessionsaver,smartspaces"

	# python plugins with extra dependencies
	for plugin in ${IUSE_plugins/+}; do
		use ${plugin} || continue
		# FIXME: put in REQUIRED_USE when python.eclass supports EAPI4
		if use python; then
			myplugins="${myplugins},${plugin}"
		else
			ewarn "Plugin '${plugin}' auto-disabled due to USE=-python"
		fi
	done

	DOCS="AUTHORS ChangeLog* NEWS README"

	G2CONF="${G2CONF}
		--disable-schemas-compile
		--disable-dependency-tracking
		--with-plugins=${myplugins}
		$(use_enable python)"

	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	gnome2_src_prepare

	# disable pyc compiling
	for d in . build-aux ; do
		echo > "${d}/py-compile"
	done
}

src_test() {
	emake check
}

pkg_postinst() {
	gnome2_pkg_postinst
	if use python; then
		python_need_rebuild
		python_mod_optimize /usr/{$(get_libdir),share}/gedit/plugins
	fi
}

pkg_postrm() {
	gnome2_pkg_postrm
	use python && python_mod_cleanup /usr/{$(get_libdir),share}/gedit/plugins
}
