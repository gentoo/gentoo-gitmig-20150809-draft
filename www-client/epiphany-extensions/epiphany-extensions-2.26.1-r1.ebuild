# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany-extensions/epiphany-extensions-2.26.1-r1.ebuild,v 1.7 2010/07/20 15:46:36 jer Exp $

EAPI="2"

inherit autotools eutils gnome2 python versionator

MY_MAJORV=$(get_version_component_range 1-2)

DESCRIPTION="Extensions for the Epiphany web browser"
HOMEPAGE="http://www.gnome.org/projects/epiphany/extensions.html"
SRC_URI="${SRC_URI} mirror://gentoo/${PN}-2.21.92-sessionsaver-v4.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="dbus examples pcre python"

RDEPEND="=www-client/epiphany-${MY_MAJORV}*
	app-text/opensp
	>=dev-libs/glib-2.15.5
	>=gnome-base/gconf-2.0
	>=dev-libs/libxml2-2.6
	>=x11-libs/gtk+-2.11.6
	>=gnome-base/libglade-2
	=net-libs/xulrunner-1.9*
	dbus? ( >=dev-libs/dbus-glib-0.34 )
	pcre? ( >=dev-libs/libpcre-3.9-r2 )
	python? ( >=dev-python/pygtk-2.11 )"
DEPEND="${RDEPEND}
	  gnome-base/gnome-common
	>=dev-util/intltool-0.40
	>=dev-util/pkgconfig-0.20
	>=app-text/gnome-doc-utils-0.3.2"

DOCS="AUTHORS ChangeLog HACKING NEWS README"

pkg_setup() {
	local extensions=""

	extensions="actions auto-reload auto-scroller certificates \
				error-viewer extensions-manager-ui gestures \
				livehttpheaders page-info permissions push-scroller \
				select-stylesheet sessionsaver sidebar smart-bookmarks \
				tab-groups tab-states"

	use dbus && extensions="${extensions} rss"

# java-console cannot build against xul-1.9.2, see bug #302929
#	use java && extensions="${extensions} java-console"

	use pcre && extensions="${extensions} adblock greasemonkey"

	use python && extensions="${extensions} python-console favicon cc-license-viewer epilicious"
	use python && use examples && extensions="${extensions} sample-python"

	use examples && extensions="${extensions} sample sample-mozilla"

	G2CONF="${G2CONF} --with-extensions=$(echo "${extensions}" | sed -e 's/[[:space:]]\+/,/g')"

	G2CONF="${G2CONF} --with-gecko=libxul-embedding"
}

src_prepare() {
	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile

	# Don't remove sessionsaver, please.  -dang
	epatch "${WORKDIR}"/${PN}-2.21.92-sessionsaver-v4.patch
	echo "extensions/sessionsaver/ephy-sessionsaver-extension.c" >> po/POTFILES.in

	# Fix building with libtool-1  bug #257337
	rm m4/lt* m4/libtool.m4

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}

pkg_postinst() {
	gnome2_pkg_postinst

	if use python; then
		python_mod_optimize /usr/$(get_libdir)/epiphany/${MY_MAJORV}/extensions
	fi
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup /usr/$(get_libdir)/epiphany/${MY_MAJORV}/extensions
}
