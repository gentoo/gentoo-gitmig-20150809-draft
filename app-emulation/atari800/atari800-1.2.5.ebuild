# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-emulation/atari800/atari800-1.2.5.ebuild,v 1.4 2003/06/29 20:06:54 aliz Exp $

IUSE="sdl"

S=${WORKDIR}/${P}
DESCRIPTION="Atari 800 emulator"
SRC_URI="mirror://sourceforge/atari800/${P}.tar.gz
	mirror://sourceforge/atari800/xf25.zip"
HOMEPAGE="http://atari800.sourceforge.net"
SLOT="0"
LICENSE="GPL-2"

# Haven't tested other architectures, but is reported to work on non-x86
# platforms
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND="virtual/x11
	app-arch/unzip
	sdl? ( >=media-libs/libsdl-1.2.0 )"

RDEPEND="virtual/x11
	sdl? ( >=media-libs/libsdl-1.2.0 )"

# The atari800-1.2.5-gentoo.diff backs out a "fix" in 1.2.5 over 1.2.4
# that was supposed to improve sound quality.  However, in my testing on
# two different machines and even ALSA vs. normal sound support, the 1.2.5
# version was far worse.
src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff || die
}

# The configure script in 1.2.5 changed syntax, but the change wasn't
# updated in the atari800.spec file as in the previous versions.
src_compile() {
	local target
	target="x11"
	use sdl && target="sdl"

	local myconf
	myconf="--enable-crashmenu --enable-break --enable-hints \
        --enable-asm --enable-cursorblk --enable-led --enable-displayled \
        --enable-sndclip --enable-linuxjoy --enable-sound"

	cd src
	./configure --prefix=/usr --target=$target ${myconf}
	emake
	mv atari800.man atari800.1
}

# The makefile doesn't supply an install routine, so we have to do it
# ourselves.
src_install () {
	into /usr
	dodir /usr/bin /usr/share/man/man1 /usr/share/atari800
	dobin src/atari800
	doman src/atari800.1
	dodoc COPYING README.1ST DOC/USAGE DOC/README DOC/NEWS DOC/FAQ DOC/CREDITS DOC/BUGS DOC/LPTjoy.txt DOC/cart.txt DOC/pokeysnd.txt
	insinto /usr/share/atari800
	doins ${WORKDIR}/*.ROM

	# Basic config file for /etc directory.  An atari800.cfg file
	# in the current directory will be loaded instead of the
	# global file, if it exists.  Run "atari800 -configure" to
	# have the emulator prompt for new values
	insinto /etc
	doins ${FILESDIR}/${PVR}/atari800.cfg
}

pkg_postinst() {
	if [ "`use sdl`" ]
	then
	  echo ' '
	  echo ' '
	  echo 'The emulator has been compiled using the SDL libraries.  By default,'
	  echo 'atari800 switches to fullscreen mode, so a 400x300 entry in your'
	  echo 'XF86Config-4 file is recommended.  Otherwise, the emulated Atari'
	  echo 'screen is postage-stamp sized in the middle of your display.'
	  echo ' '
	  echo 'For example, in the "Screen" section of your /etc/XF86Config-4 file,'
	  echo 'add the entry "400x300" to the end of the list of modes:'
	  echo ' '
	  echo '  Section "Screen"'
	  echo '    [...]'
	  echo ' '
	  echo '      Subsection "Display"'
	  echo '          Depth       16'
	  echo '          Modes       "1600x1200" "1024x768" "400x300"'
	  echo '          ViewPort    0 0'
	  echo '      EndSubsection'
	  echo '  EndSection'
	  echo ' '
	  echo 'You should not need to specify a modeline for this mode, since in most'
	  echo 'cases it is a standard mode calculated by the X server.'
	  echo ' '
	  echo ' '
	  echo ' '
	fi
}
