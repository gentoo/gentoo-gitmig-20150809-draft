# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Based on the 0.59.1 ebuild by Ben Lutgens <blutgens@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xmame/xmame-0.60.1-r1.ebuild,v 1.3 2002/07/27 16:15:23 stubear Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Multiple Arcade Machine Emulator for X11"
SRC_URI="http://x.mame.net/download/${P}.tar.bz2"
HOMEPAGE="http://x.mame.net"
SLOT="0"
LICENSE="xmame"
KEYWORDS="x86"
DEPEND="virtual/x11
		sdl? ( >=media-libs/libsdl-1.2.0 )
		>=sys-libs/zlib-1.1.3-r2"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e "s:CFLAGS    = -O -Wall:\#CFLAGS=:g" -e \
	"s:PREFIX = /usr/local:PREFIX = /usr:g" -e \
	"s:MANDIR = \$\(PREFIX\)/man/man6:MANDIR = \$\(PREFIX\)/share/man/man6:g" \
	makefile.unix > makefile.unix.tmp
	mv makefile.unix.tmp makefile.unix

	# Enable joystick support
	sed -e "s/\# JOY_I386/JOY_I386/g" makefile.unix > makefile.unix.tmp
	mv makefile.unix.tmp makefile.unix

	if [ "`use dga`" ]; then
		sed -e "s/\# X11_DGA = 1/X11_DGA = 1/g" \
		makefile.unix > makefile.unix.tmp
		mv makefile.unix.tmp makefile.unix
	fi

	if [ "`use sdl`" ]; then
		sed -e "s:DISPLAY_METHOD = x11:DISPLAY_METHOD = SDL:g" \
		makefile.unix > makefile.unix.tmp
		mv makefile.unix.tmp makefile.unix
	fi
	
	if [ "`use esd`" ]; then
		sed -e "s/\# SOUND_ESOUND/SOUND_ESOUND/g" makefile.unix > Makefile
	else
		mv makefile.unix Makefile
	fi
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install () {

	make PREFIX=${D}/usr install

# dodoc gzips
	dodoc doc/{changes.*,dga2.txt,gamelist.mame,readme.mame,xmamerc.dist}
	dodoc doc/{xmame-doc.ps,xmame-doc.txt}
# Don't really want html files gzipped
	insinto /usr/share/doc/${P}/html
	doins doc/*.html
	if [ "`use sdl`" ]; then
		dosym xmame.SDL /usr/bin/xmame
	else
		dosym xmame.x11 /usr/bin/xmame
	fi
}
