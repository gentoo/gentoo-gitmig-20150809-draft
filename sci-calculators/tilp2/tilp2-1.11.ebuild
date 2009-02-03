# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/tilp2/tilp2-1.11.ebuild,v 1.1 2009/02/03 15:52:59 bicatali Exp $

EAPI="2"
inherit eutils kde-functions

DESCRIPTION="Communication program for Texas Instruments calculators "
HOMEPAGE="http://lpg.ticalc.org/prj_tilp"
SRC_URI="mirror://sourceforge/tilp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kde nls threads xinerama"

RDEPEND="sci-libs/libticalcs2
	sci-libs/libticables2
	sci-libs/libtifiles2
	sci-libs/libticonv
	!sci-calculators/tilp
	>=x11-libs/gtk+-2.6.0
	>=dev-libs/glib-2.6.0
	>=gnome-base/libglade-2
	kde? ( kde-base/kdelibs:3.5 )
	nls? ( virtual/libintl )
	xinerama? ( x11-libs/libXinerama )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	xinerama? ( x11-proto/xineramaproto )"

src_configure() {
	use kde && set-kdedir 3
	econf \
		--disable-rpath \
		$(use_enable threads) \
		$(use_enable threads threading) \
		$(use_with kde) \
		$(use_with xinerama)
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	rm -f "${D}"usr/share/tiemu/{Manpage.txt,COPYING,RELEASE,AUTHORS,LICENSES}
	dodoc README AUTHORS ChangeLog RELEASE TODO *.txt
	make_desktop_entry tilp "TILP2 TI Linker" \
		/usr/share/tilp2/pixmaps/icon.xpm
}
