# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/katoob/katoob-0.5.9.1.ebuild,v 1.1 2008/05/21 07:20:53 remi Exp $

inherit eutils gnome2

DESCRIPTION="A light-weight multilingual BiDi aware text editor"
HOMEPAGE="http://foolab.org/projects/katoob"
SRC_URI="ftp://foolab.org/pub/software/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
	highlight? ( dev-cpp/gtksourceviewmm )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.28
	>=dev-util/pkgconfig-0.9"

pkg_setup() {
	G2CONF="$(use_enable spell aspell) \
		$(use_enable bidi fribidi) \
		$(use_enable cups print) \
		$(use_enable bzip2) \
		$(use_enable dbus) \
		$(use_enable highlight) \
		$(use_enable !debug release)"
}

#src_install() {
#	make DESTDIR="${D}" install || die "Installation failed"
#
#	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
#}
