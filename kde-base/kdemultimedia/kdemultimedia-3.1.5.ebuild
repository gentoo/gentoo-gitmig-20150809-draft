# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia/kdemultimedia-3.1.5.ebuild,v 1.9 2004/06/09 14:44:12 agriffis Exp $
inherit kde-dist flag-o-matic

IUSE="nas esd motif slang tcltk oggvorbis cdr"
DESCRIPTION="KDE multimedia apps: noatun, kscd, artsbuilder..."
KEYWORDS="x86 sparc ~ppc hppa amd64 alpha ia64"

DEPEND=">=sys-libs/ncurses-5.2
	>=media-sound/cdparanoia-3.9.8
	>=media-libs/libvorbis-1.0_beta4
	!hppa? ( !ia64? ( >=media-video/xanim-2.80.1 ) )
	nas? ( >=media-libs/nas-1.4.1 )
	esd? ( >=media-sound/esound-0.2.22 )
	motif? ( x11-libs/openmotif )
	slang? ( >=sys-libs/slang-1.4.4 )
	virtual/mpg123
	tcltk? ( >=dev-lang/tk-8.0.5-r2 )
	>=dev-libs/glib-1.3.3
	oggvorbis? ( media-libs/libvorbis )
	>=media-libs/xine-lib-1_beta10"
	#gtk? ( =x11-libs/gtk+-1.2* )
#	alsa? ( >=media-libs/alsa-lib-0.5.9 )"

RDEPEND="$DEPEND
	cdr? ( app-cdr/cdrtools
	>=app-cdr/cdrdao-1.1.5 )"

replace-flags "-O3" "-O2"
filter-flags "-fno-default-inline"

myaudio="--enable-audio=oss"
myinterface="--enable-interface=xaw,ncurses"
myconf="$myconf --enable-xaw --enable-ncurses"
myconf="$myconf --with-xine-prefix=/usr"

# make -j2 fails, at least on ppc
export MAKEOPTS="$MAKEOPTS -j1"

PATCHES="$FILESDIR/$P-gentoo-timidity.diff
	$FILESDIR/$P-ln-sf.diff
	$FILESDIR/$P-alpha.diff"

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

# Robin Johnson <robbat2@gentoo.org> 23/01/2004
# fixes bug #38326 
myconf="${myconf} --disable-strict --disable-warnings"

myconf="$myconf $myaudio $myinterface"

pkg_postinst() {
	if use alsa; then
	einfo "WARNING: alsa support has been removed becuase of a bug in kdemm sources.
For further information see bug #2324 on bugs.gentoo.org and bug #39574 on bugs.kde.org.
Meanwhile, you can use the alsa oss emulation."
	fi
}
