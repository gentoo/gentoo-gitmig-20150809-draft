# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/gelemental/gelemental-1.2.0.ebuild,v 1.5 2011/03/02 17:49:59 jlec Exp $

EAPI="1"

inherit fdo-mime gnome2-utils eutils

DESCRIPTION="a periodic table viewer that provides detailed information on the
chemical elements."
HOMEPAGE="http://www.kdau.com/projects/gelemental"
SRC_URI="http://www.kdau.com/files/${P}.tar.bz2"

LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

RDEPEND="
	dev-cpp/gtkmm:2.4
	dev-cpp/glibmm:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	dev-util/intltool
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc4.3.patch
}

src_compile() {
	econf --disable-dependency-tracking $(use_enable doc api-docs)
	emake || die "emake failed."
}

src_install() {
	emake apidir="/usr/share/doc/${PF}/html" DESTDIR="${D}" \
		install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS* README TODO TRANSLATORS
}

pkg_postinst() {
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
}
