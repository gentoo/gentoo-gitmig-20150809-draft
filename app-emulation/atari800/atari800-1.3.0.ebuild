# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/atari800/atari800-1.3.0.ebuild,v 1.6 2003/09/04 01:17:11 msterret Exp $

DESCRIPTION="Atari 800 emulator"
HOMEPAGE="http://atari800.sourceforge.net/"
SRC_URI="mirror://sourceforge/atari800/${P}.tar.gz
	mirror://sourceforge/atari800/xf25.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
IUSE="sdl"

RDEPEND="virtual/x11
	sdl? ( >=media-libs/libsdl-1.2.0 )"
DEPEND="${RDEPEND}
	app-arch/unzip"

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
	emake || die "emake failed"
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
	if [ "`use sdl`" ] ; then
		echo
		echo
		einfo 'The emulator has been compiled using the SDL libraries.  By default,'
		einfo 'atari800 switches to fullscreen mode, so a 400x300 entry in your'
		einfo 'XF86Config-4 file is recommended.  Otherwise, the emulated Atari'
		einfo 'screen is postage-stamp sized in the middle of your display.'
		echo
		einfo 'For example, in the "Screen" section of your /etc/XF86Config-4 file,'
		einfo 'add the entry "400x300" to the end of the list of modes:'
		echo
		einfo '  Section "Screen"'
		einfo '    [...]'
		einfo
		einfo '      Subsection "Display"'
		einfo '          Depth       16'
		einfo '          Modes       "1600x1200" "1024x768" "400x300"'
		einfo '          ViewPort    0 0'
		einfo '      EndSubsection'
		einfo '  EndSection'
		echo
		einfo 'You should not need to specify a modeline for this mode,'
		einfo 'since in most cases it is a standard mode calculated by'
		einfo 'the X server.'
		echo
		echo
		echo
	fi
}
