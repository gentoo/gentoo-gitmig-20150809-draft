# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/geda-gschem/geda-gschem-1.4.3.ebuild,v 1.1 2009/05/20 02:15:06 calchan Exp $

EAPI="2"

inherit fdo-mime versionator

DESCRIPTION="GPL Electronic Design Automation: schematic editor"
HOMEPAGE="http://www.gpleda.org/"
SRC_URI="http://geda.seul.org/release/v$(get_version_component_range 1-2)/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="nls stroke threads"

RDEPEND="=sci-libs/libgeda-${PV}*
	=sci-electronics/geda-symbols-${PV}*
	>=dev-libs/glib-2.4
	>=x11-libs/gtk+-2.4
	|| ( =dev-scheme/guile-1.6* =dev-scheme/guile-1.8*[deprecated] )
	nls? ( virtual/libintl )
	stroke? ( >=dev-libs/libstroke-0.5.1 )"

DEPEND="${RDEPEND}
	!<sci-electronics/geda-1.4.3-r1
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.9
	nls? ( sys-devel/gettext )"

src_prepare() {
	sed -i -e 's/ docs / /' Makefile.in || die "sed failed"
}

src_configure() {
	# nls may not work if LINGUAS is set -- upstream bug, they use only variants
	# like de_DE.po. See Debian bug #336796
	use nls && unset LINGUAS
	econf \
		$(use_enable threads threads posix) \
		$(use_enable stroke) \
		$(use_enable nls) \
		--disable-dependency-tracking \
		--disable-rpath \
		--disable-update-mime-database \
		--disable-update-desktop-database
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS BUGS NEWS README
	doman docs/gschem.1
}

pkg_postinst() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}

