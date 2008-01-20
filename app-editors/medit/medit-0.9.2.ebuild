# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/medit/medit-0.9.2.ebuild,v 1.1 2008/01/20 16:15:15 drac Exp $

inherit eutils python fdo-mime gnome2-utils multilib

DESCRIPTION="Multiplatform text editor"
HOMEPAGE="http://mooedit.sourceforge.net"
SRC_URI="mirror://sourceforge/mooedit/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="fam nls python xml"

RDEPEND="fam? ( virtual/fam )
	python? ( dev-python/pygtk )
	xml? ( dev-libs/libxml2 )
	>=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig
	dev-libs/libxslt"

RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e 's:update-mime-database:true:' \
		moo/mooedit/language-specs/Makefile.in || die "sed failed."
	sed -i -e 's:gtk-update-icon-cache:true:g' medit/Makefile.in || die "sed failed."

	epatch "${FILESDIR}"/${P}-desktop-entry.patch
}
src_compile() {
	econf $(use_with fam) $(use_with nls) \
		$(use_with python) $(use_with xml)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS NEWS README THANKS
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	use python && python_mod_optimize "${ROOT}"usr/$(get_libdir)/moo/plugins
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	use python && python_mod_cleanup
}
