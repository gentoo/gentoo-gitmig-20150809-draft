# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/katoob/katoob-0.5.6.ebuild,v 1.3 2007/07/08 00:20:48 mr_bones_ Exp $

inherit eutils

DESCRIPTION="A light-weight multilingual BiDi aware text editor"
HOMEPAGE="http://foolab.org/projects/katoob"
SRC_URI="ftp://foolab.org/pub/software/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="bidi bzip2 cups dbus debug highlight spell"

RDEPEND=">=dev-cpp/gtkmm-2.6
	>=dev-libs/glib-2
	spell? ( app-text/aspell )
	bidi? ( dev-libs/fribidi )
	cups? (
		>=net-print/cups-1.1.23
		>=x11-libs/pango-1 )
	bzip2? ( app-arch/bzip2 )
	dbus? ( dev-libs/dbus-glib )
	highlight? ( >=dev-cpp/libgtksourceviewmm-0.2 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.28
	>=dev-util/pkgconfig-0.9"

src_compile() {
	local myconf="$(use_enable spell aspell) \
		$(use_enable bidi fribidi) \
		$(use_enable cups print) \
		$(use_enable bzip2) \
		$(use_enable dbus) \
		$(use_enable highlight) \
		$(use_enable !debug release)"

	econf ${myconf} || die "econf failed"
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
