# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/shermans-aquarium/shermans-aquarium-2.2.0.ebuild,v 1.14 2006/08/21 03:22:39 tcort Exp $

inherit eutils

MY_P=${PN/-/_}-${PV}
DESCRIPTION="A gnome/wm applet displaying comical fish"
HOMEPAGE="http://aquariumapplet.sourceforge.net"
SRC_URI="mirror://sourceforge/aquariumapplet/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="sdl"

DEPEND=">=x11-libs/gtk+-2
		>=gnome-base/libgnome-2
		>=gnome-base/libgnomeui-2
		>=gnome-base/gnome-applets-2
		sdl?   ( >=media-libs/libsdl-1.2
				   x11-misc/xscreensaver )"

# redefine ${S} to point to the correct source, needs
# the _ switched for - because of the source naming
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}; epatch ${FILESDIR}/${P}-gcc-v.patch
	autoconf
}

src_compile( ) {

	cd ${S}
	local myconf
	# if we dont want sdl (fullscreen support)
	if ! use sdl; then
		myconf="${myconf} --disable-fullscreen"
	fi

	econf ${myconf} || die
	emake || die

}

src_install( ) {

	# we need to create some dirs that arent created in the
	# Makefile.
	dodir /usr/lib/bonobo/servers /usr/share/gnome-2.0/ui
	dodir /usr/share/pixmaps
	make DESTDIR=${D} install || die

	dodoc FAQ README XSCREENSAVER

}

