# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freeciv/freeciv-1.14.1_beta4.ebuild,v 1.1 2003/11/22 02:43:32 mr_bones_ Exp $

inherit games

S="${WORKDIR}/${PN}-${PV/_/-}"
DESCRIPTION="multiplayer strategy game (Civilization Clone)"
HOMEPAGE="http://www.freeciv.org/"
SRC_URI="ftp://ftp.freeciv.org/freeciv/beta/${PN}-${PV/_/-}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="X Xaw3d gtk gtk2 sdl nls"

DEPEND=">=sys-devel/gettext-0.10.36
	>=sys-devel/autoconf-2.13
	>=sys-devel/automake-1.4
	>=sys-devel/bison-1.35
	sys-libs/zlib
	X? ( virtual/x11 )
	Xaw3d? ( x11-libs/Xaw3d )
	media-libs/sdl-mixer
	media-libs/sdl-image
	>=media-libs/libsdl-1.1.4
	gtk? (
			!gtk2? (
				=x11-libs/gtk+-1*
				>=dev-libs/glib-1.2.5
				>=media-libs/imlib-1.9.2
			)
			gtk2? (
				>=x11-libs/gtk+-2.0.0
				>=dev-libs/glib-2.0.0
				>=dev-libs/atk-1.0.3
				>=x11-libs/pango-1.0.5
			)
			>=media-libs/libogg-1.0
			>=media-libs/libvorbis-1.0-r2
		)"

src_compile() {
	local myconf="--enable-client=no"

	use X \
		&& myconf="${myconf} --enable-client=xaw --with-x" \
		|| myconf="${myconf} --disable-client=xaw --without-x"

	use Xaw3d \
		&& myconf="${myconf} --enable-client=xaw3d --disable-gtktest"

	if [ `use gtk` ] ; then
		myconf="${myconf} --enable-gtktest"
		if [ `use gtk2` ] ; then
			myconf="${myconf} --enable-client=gtk-2.0"
		else
			myconf="${myconf} --enable-client=gtk"
		fi
	else
		myconf="${myconf} --disable-client --disable-gtktest"
	fi

	egamesconf \
		--disable-dependency-tracking \
		--with-zlib \
		`use_enable nls` \
		${myconf} || die
	emake || die "emake failed"
}

src_install() {
	make prefix=${D}/usr datadir=${D}/${GAMES_DATADIR} install || \
		die "make install failed"

	use gtk	|| /bin/install -D -m 644 \
		${S}/data/Freeciv \
		${D}/usr/X11R6/lib/X11/app-defaults/Freeciv || \
			die "install failed"

	dodoc ChangeLog INSTALL NEWS \
		doc/{BUGS,CodingStyle,HACKING,HOWTOPLAY,PEOPLE,README*,TODO} || \
			die "dodoc failed"
	prepgamesdirs
}
