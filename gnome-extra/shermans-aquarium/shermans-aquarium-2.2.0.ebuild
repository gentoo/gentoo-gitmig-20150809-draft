# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/shermans-aquarium/shermans-aquarium-2.2.0.ebuild,v 1.5 2004/04/03 23:31:49 spyderous Exp $

MY_P=${PN/-/_}-${PV}
DESCRIPTION="A gnome/wm applet displaying comical fish"
HOMEPAGE="http://aquariumapplet.sourceforge.net"
SRC_URI="mirror://sourceforge/aquariumapplet/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
# this applet contains support for either using gnome1, gnome2,
# gtk1, or gtk2, so we could use something like
# if gtk is enabled, then that infers to build for gnome1
# if gtk2 is enabled, it infers to build for gnome2
# it's not possible to cross build (eg, gtk1 and gnome2)
# as outlined in the INSTALL file provided with the source
IUSE="gtk2 sdl"

DEPEND="virtual/x11
		!gtk2? (  =x11-libs/gtk+-1.2*
				   media-libs/gdk-pixbuf
				  =gnome-base/gnome-applets-1.4* )
		gtk2?  ( >=gnome-base/libgnome-2
				 >=gnome-base/gnome-applets-2 )
		sdl?   ( >=media-libs/libsdl-1.2
				   x11-misc/xscreensaver )"

# redefine ${S} to point to the correct source, needs
# the _ switched for - because of the source naming
S=${WORKDIR}/${MY_P}

src_compile( ) {

	cd ${S}
	local myconf
	# if we dont want gtk2 support
	if [ -z "`use gtk2`" ]; then
		myconf="${myconf} --disable-gtk2 --disable-gnome2"
	fi
	# if we dont want sdl (fullscreen support)
	if [ -z "`use sdl`" ]; then
		myconf="${myconf} --disable-fullscreen"
	fi

	econf ${myconf} || die
	emake || die

}

src_install( ) {

	# we need to create some dirs that arent created in the
	# Makefile. which ones depend on whether we're building
	# for gtk1 or gtk2
	if [ -n "`use gtk2`" ]; then
		dodir /usr/lib/bonobo/servers /usr/share/gnome-2.0/ui
	else
		dodir /etc/CORBA/servers /usr/share/applets/Amusements
	fi
	dodir /usr/share/pixmaps
	make DESTDIR=${D} install || die

	dodoc FAQ README XSCREENSAVER

}

