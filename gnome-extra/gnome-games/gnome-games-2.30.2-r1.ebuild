# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-games/gnome-games-2.30.2-r1.ebuild,v 1.11 2011/02/15 08:17:13 eva Exp $

EAPI="2"
GCONF_DEBUG="no"
WANT_AUTOMAKE="1.11"

# make sure games is inherited first so that the gnome2
# functions will be called if they are not overridden
inherit games games-ggz gnome2 python virtualx

DESCRIPTION="Collection of games for the GNOME desktop"
HOMEPAGE="http://live.gnome.org/GnomeGames/"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm ia64 ppc ppc64 sh sparc ~x86 ~x86-fbsd"
IUSE="artworkextra +clutter guile opengl test"

# USE=clutter also enables introspection because gnome-games is the only known
# consumer of introspection on libgames-support etc. If something else pops up,
# we'll have to enable it unconditionally because we have no sane way of
# representing inter-use-flag dependencies
COMMON_DEPEND="
	>=dev-games/libggz-0.0.14
	>=dev-games/ggz-client-libs-0.0.14
	>=dev-libs/dbus-glib-0.75
	>=dev-libs/glib-2.6.3:2
	>=dev-libs/libxml2-2.4.0
	>=dev-python/gconf-python-2.17.3
	>=dev-python/pygobject-2:2
	>=dev-python/pygtk-2.14:2
	>=dev-python/pycairo-1
	>=gnome-base/gconf-2
	>=gnome-base/librsvg-2.14
	media-libs/libcanberra[gtk]
	>=x11-libs/cairo-1
	>=x11-libs/gtk+-2.16:2
	x11-libs/libSM

	artworkextra? ( gnome-extra/gnome-games-extra-data )
	clutter? (
		>=dev-libs/gobject-introspection-0.6.3
		>=media-libs/clutter-1.0.0:1.0
		>=media-libs/clutter-gtk-0.10.2:0.10 )
	guile? ( >=dev-scheme/guile-1.6.5[deprecated,regex] )
	opengl? (
		dev-python/pygtkglext
		>=dev-python/pyopengl-3 )
	!games-board/glchess"
RDEPEND="${COMMON_DEPEND}
	clutter? (
		dev-libs/seed
		x11-libs/gtk+[introspection]
		>=media-libs/clutter-1.0.0:1.0[introspection]
		>=media-libs/clutter-gtk-0.10.2:0.10[introspection] )"
DEPEND="${COMMON_DEPEND}
	>=sys-devel/autoconf-2.53
	>=dev-util/pkgconfig-0.15
	>=dev-util/intltool-0.40.4
	>=sys-devel/gettext-0.10.40
	>=gnome-base/gnome-common-2.12.0
	>=app-text/scrollkeeper-0.3.8
	>=app-text/gnome-doc-utils-0.10
	test? ( >=dev-libs/check-0.9.4 )"

# Others are installed below; multiples in this package.
DOCS="AUTHORS HACKING MAINTAINERS TODO"

# dang make-check fails on docs with -j > 1.  Restrict them for the moment until
# it can be chased down.
RESTRICT="test"

_omitgame() {
	G2CONF="${G2CONF},${1}"
}

pkg_setup() {
	# create the games user / group
	games_pkg_setup

	G2CONF="${G2CONF}
		$(use_enable clutter introspection)
		--disable-aisleriot-clutter
		--disable-card-themes-installer
		--enable-sound
		--with-scores-group=${GAMES_GROUP}
		--with-platform=gnome
		--with-card-theme-formats=all
		--with-smclient
		--enable-omitgames=none" # This line should be last for _omitgame

	if ! use clutter; then
		ewarn "USE=-clutter means no quadrapassel, lightsoff, swell-foop, gnibbles"
		_omitgame quadrapassel
		_omitgame lightsoff
		_omitgame swell-foop
		_omitgame gnibbles
	fi

	if ! use guile; then
		ewarn "USE=-guile implies that Aisleriot won't be installed"
		_omitgame aisleriot
	fi

	if ! use opengl; then
		ewarn "USE=-opengl implies that glchess won't be installed"
		_omitgame glchess
	fi
}

src_prepare() {
	gnome2_src_prepare

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile
}

src_test() {
	Xemake check || die "tests failed"
}

src_install() {
	gnome2_src_install

	# Documentation install for each of the games
	for game in \
	$(find . -maxdepth 1 -type d ! -name po ! -name libgames-support); do
		docinto ${game}
		for doc in AUTHORS ChangeLog NEWS README TODO; do
			[ -s ${game}/${doc} ] && dodoc ${game}/${doc}
		done
	done
}

pkg_preinst() {
	gnome2_pkg_preinst
	# Avoid overwriting previous .scores files
	local basefile
	for scorefile in "${D}"/var/lib/games/*.scores; do
		basefile=$(basename $scorefile)
		if [ -s "${ROOT}/var/lib/games/${basefile}" ]; then
			cp "${ROOT}/var/lib/games/${basefile}" \
			"${D}/var/lib/games/${basefile}"
		fi
	done
}

pkg_postinst() {
	games_pkg_postinst
	games-ggz_update_modules
	gnome2_pkg_postinst
	python_need_rebuild
	python_mod_optimize $(python_get_sitedir)/gnome_sudoku
	if use opengl; then
		python_mod_optimize $(python_get_sitedir)/glchess
	fi
}

pkg_postrm() {
	games-ggz_update_modules
	gnome2_pkg_postrm
	python_mod_cleanup /usr/$(get_libdir)/python*/site-packages/{gnome_sudoku,glchess}
	python_mod_cleanup /usr/$(get_libdir)/python*/site-packages/glchess
}
