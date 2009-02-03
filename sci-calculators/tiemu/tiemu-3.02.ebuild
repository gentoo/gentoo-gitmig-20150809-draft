# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/tiemu/tiemu-3.02.ebuild,v 1.1 2009/02/03 15:49:54 bicatali Exp $

EAPI=2
inherit eutils kde-functions

DESCRIPTION="Texas Instruments hand-helds emulator"
HOMEPAGE="http://lpg.ticalc.org/prj_tiemu/"
SRC_URI="mirror://sourceforge/gtktiemu/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus kde nls sdl threads xinerama"

RDEPEND="sci-libs/libticables2
	sci-libs/libticalcs2
	sci-libs/libtifiles2
	sci-libs/libticonv
	>=gnome-base/libglade-2.4.0
	>=x11-libs/gtk+-2.6.0
	dbus? ( >=dev-libs/dbus-glib-0.60 )
	kde? ( kde-base/kdelibs:3.5 )
	nls? ( virtual/libintl )
	sdl? ( media-libs/libsdl )
	xinerama? ( x11-libs/libXinerama )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	xinerama? ( x11-proto/xineramaproto )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_configure() {
	use kde && set-kdedir 3
	econf \
		--disable-rpath \
		--disable-debugger \
		--disable-gdb \
		$(use_enable nls) \
		$(use_enable sdl sound) \
		$(use_enable threads) \
		$(use_enable threads threading) \
		$(use_with dbus) \
		$(use_with kde) \
		$(use_with xinerama)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -f "${D}"usr/share/tiemu/{Manpage.txt,COPYING,RELEASE,AUTHORS,LICENSES}
	dodoc AUTHORS NEWS README README.linux RELEASE THANKS TODO *.txt
	make_desktop_entry tiemu "TiEmu Calculator" \
		/usr/share/tiemu/pixmaps/icon.xpm
}
