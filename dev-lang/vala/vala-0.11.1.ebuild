# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/vala/vala-0.11.1.ebuild,v 1.1 2010/10/27 20:59:13 eva Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Vala - Compiler for the GObject type system"
HOMEPAGE="http://live.gnome.org/Vala"

LICENSE="LGPL-2.1"
SLOT="0.12"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="test +vapigen coverage"

RDEPEND=">=dev-libs/glib-2.16"
DEPEND="${RDEPEND}
	sys-devel/flex
	|| ( sys-devel/bison dev-util/byacc dev-util/yacc )
	dev-util/pkgconfig
	dev-libs/libxslt
	test? (
		dev-libs/dbus-glib
		>=dev-libs/glib-2.26 )"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-unversioned
		$(use_enable vapigen)
		$(use_enable coverage)"
	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"

	if use coverage && has ccache ${FEATURES}; then
		ewarn "USE=coverage does not work well with ccache; valac and libvala"
		ewarn "built with ccache and USE=coverage create temporary files inside"
		ewarn "CCACHE_DIR and mess with ccache's working, as well as causing"
		ewarn "sandbox violations when used to compile other packages."
		ewarn "It is STRONGLY recommended that you disable one of them."
	fi
}

src_install() {
	gnome2_src_install
	mv "${ED}"/usr/share/aclocal/vala.m4 \
		"${ED}"/usr/share/aclocal/vala-${SLOT/./-}.m4 || die "failed to move vala m4 macro"
	find "${ED}" -name "*.la" -delete || die "la file removal failed"
}
