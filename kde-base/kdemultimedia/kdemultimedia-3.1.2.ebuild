# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia/kdemultimedia-3.1.2.ebuild,v 1.2 2003/05/20 23:26:15 weeve Exp $
inherit kde-dist flag-o-matic 

IUSE="nas esd motif slang tcltk oggvorbis cdr"
DESCRIPTION="KDE multimedia apps: noatun, kscd, artsbuilder..."
KEYWORDS="x86 ~ppc sparc ~alpha"

newdepend ">=sys-libs/ncurses-5.2
	>=media-sound/cdparanoia-3.9.8
	>=media-libs/libvorbis-1.0_beta4
	>=media-video/xanim-2.80.1
	nas? ( >=media-libs/nas-1.4.1 )
	esd? ( >=media-sound/esound-0.2.22 )
	motif? ( virtual/motif )
	slang? ( >=sys-libs/slang-1.4.4 )
	>=media-sound/mpg123-0.59r
	tcltk? ( >=dev-lang/tk-8.0.5-r2 )
	>=dev-libs/glib-1.3.3
	oggvorbis? ( media-libs/libvorbis )"
	#>=media-libs/xine-lib-0.9.14" # not yet available
	#gtk? ( =x11-libs/gtk+-1.2* )
#	alsa? ( >=media-libs/alsa-lib-0.5.9 )"

RDEPEND="$RDEPEND
	cdr? ( app-cdr/cdrtools
	>=app-cdr/cdrdao-1.1.5 )"

replace-flags "-O3" "-O2"

myaudio="--enable-audio=oss"
myinterface="--enable-interface=xaw,ncurses"
myconf="$myconf --enable-xaw --enable-ncurses"
#myconf="$myconf --with-xine-prefix=/usr"

# make -j2 fails, at least on ppc
export MAKEOPTS="$MAKEOPTS -j1"

PATCHES="$FILESDIR/$P-gentoo-timidity.diff
	$FILESDIR/$P-ln-sf.diff"

# alsa 0.9 not supported
#use alsa	&& myconf="$myconf --with-alsa --with-arts-alsa" && myaudio="$myaudio,alsa" || myconf="$myconf --without-alsa --disable-alsa"
use nas		&& myaudio="$myaudio,nas --with-nas-library=/usr/X11R6/lib/libaudio.so --with-nas-includes=/usr/X11R6/include" || myconf="$myconf --disable-nas"
use esd		&& myaudio="$myaudio,esd"			|| myconf="$myconf --disable-esd"
use motif	&& myinterface="$myinterface,motif" && myconf="$myconf --enable-motif"
# kmidi/TIMIDITY miscompiles with gtk
#use gtk		&& myinterface="$myinterface,gtk"   && myconf="$myconf --enable-gtk"
use slang	&& myinterface="$myinterface,slang" && myconf="$myconf --enable-slang"
use tcltk	&& myinterface="$myinterface,tcltk" && myconf="$myconf --enable-tcltk"
use oggvorbis	&& myconf="$myconf --with-vorbis=/usr"		|| myconf="$myconf --without-vorbis"

use cdr		|| KDE_REMOVE_DIR="kaudiocreator"

# xine doesn't compile yet
# also turn off kaudiocreator if cdr isn't in use
KDE_REMOVE_DIR="xine_artsplugin"
[ -z "`use cdr`" ] && KDE_REMOVE_DIR="$KDE_REMOVE_DIR kaudiocreator"

myconf="$myconf $myaudio $myinterface"

pkg_postinst() {
	if [ -n "`use alsa`" ]; then
	einfo "WARNING: alsa support has been removed becuase of a bug in kdemm sources.
For further information see bug #2324 on bugs.gentoo.org and bug #39574 on bugs.kde.org.
Meanwhile, you can use the alsa oss emulation."
	fi
}
