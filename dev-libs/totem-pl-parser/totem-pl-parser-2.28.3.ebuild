# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/totem-pl-parser/totem-pl-parser-2.28.3.ebuild,v 1.3 2010/07/20 01:51:51 jer Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Playlist parsing library"
HOMEPAGE="http://www.gnome.org/projects/totem/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
# TODO: Re-generate doc ?
IUSE="doc introspection test"

RDEPEND=">=dev-libs/glib-2.21.6
	>=x11-libs/gtk+-2.12
	dev-libs/gmime:2.4"
DEPEND="${RDEPEND}
	!<media-video/totem-2.21
	>=dev-util/intltool-0.35
	doc? ( >=dev-util/gtk-doc-1.11 )"

DOCS="AUTHORS ChangeLog NEWS"

pkg_setup() {
	G2CONF="${G2CONF} --disable-static $(use_enable introspection)"
}

src_prepare() {
	gnome2_src_prepare

	# FIXME: disable some broken tests, report upstream
	sed -e 's,^\(.*/parser/resolution.*\)$,/*\1*/,' \
		-e 's,^\(.*/parser/parsability.*\)$,/*\1*/,' \
		-e 's,^\(.*/parser/parsing/hadess.*\)$,/*\1*/,' \
		-i plparse/tests/parser.c || die
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	emake check || die "emake check failed"
}
