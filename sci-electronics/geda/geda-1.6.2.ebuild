# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/geda/geda-1.6.2.ebuild,v 1.3 2011/04/25 13:44:57 tomjbe Exp $

EAPI="2"

inherit fdo-mime versionator gnome2-utils

MY_P="${PN}-gaf-${PV}"
DESCRIPTION="GPL Electronic Design Automation (gEDA):gaf core package"
HOMEPAGE="http://www.gpleda.org/"
SRC_URI="http://geda.seul.org/release/v$(get_version_component_range 1-2)/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="debug doc examples nls stroke threads"

CDEPEND="
	dev-libs/glib:2
	x11-libs/gtk+:2
	>=x11-libs/cairo-1.2.0
	>=dev-scheme/guile-1.8[deprecated]
	nls? ( virtual/libintl )
	stroke? ( >=dev-libs/libstroke-0.5.1 )"

DEPEND="${CDEPEND}
	sys-apps/groff
	dev-util/desktop-file-utils
	x11-misc/shared-mime-info
	>=dev-util/pkgconfig-0.15.0
	nls? ( >=sys-devel/gettext-0.16 )"

RDEPEND="${CDEPEND}
	sci-electronics/electronics-menu"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	if ! use doc ; then
		sed -i -e '/^SUBDIRS = /s/docs//' Makefile.in || die "sed failed"
	fi
	if ! use examples ; then
		sed -i -e 's/\texamples$//' Makefile.in || die "sed failed"
	fi
}

src_configure() {
	econf \
		--docdir=/usr/share/doc/${PF} \
		$(use_enable threads threads posix) \
		$(use_with stroke libstroke) \
		$(use_enable nls) \
		$(use_enable debug assert) \
		--disable-doxygen \
		--disable-dependency-tracking \
		--disable-rpath \
		--disable-update-xdg-database
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS NEWS README
}

src_test() {
	emake -j1 check || die "test failed"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
