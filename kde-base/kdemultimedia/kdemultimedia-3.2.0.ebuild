# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia/kdemultimedia-3.2.0.ebuild,v 1.4 2004/02/10 06:53:39 pylon Exp $
inherit kde-dist flag-o-matic

IUSE="nas encode esd motif slang tcltk oggvorbis gtk alsa gstreamer"
DESCRIPTION="KDE multimedia apps: noatun, kscd, artsbuilder..."
KEYWORDS="~x86 ~sparc ~amd64 ppc"

DEPEND="~kde-base/kdebase-${PV}
	sys-libs/ncurses
	media-sound/cdparanoia
	media-video/xanim
	media-sound/mpg123
	encode? ( media-sound/lame )
	oggvorbis? ( media-libs/libvorbis media-libs/libogg )
	nas? ( media-libs/nas )
	esd? ( media-sound/esound )
	motif? ( x11-libs/openmotif )
	slang? ( sys-libs/slang )
	tcltk? ( dev-lang/tk dev-lang/tcl )
	>=dev-libs/glib-2.2.1
	>=media-libs/xine-lib-1_beta12
	gtk? ( =x11-libs/gtk+-1.2* )
	alsa? ( media-libs/alsa-lib )
	gstreamer? ( media-libs/gstreamer )
	media-libs/id3lib media-libs/musicbrainz media-libs/taglib
	!media-sound/juk"

RDEPEND="$DEPEND"

replace-flags "-O3" "-O2"

myaudio="--enable-audio=oss"
myinterface="--enable-interface=xaw,ncurses"
myconf="$myconf --enable-xaw --enable-ncurses"
myconf="$myconf --with-xine-prefix=/usr"

# make -j2 fails, at least on ppc
use ppc && export MAKEOPTS="$MAKEOPTS -j1"

# alsa 0.9 not supported
use alsa	&& myconf="$myconf --with-alsa --with-arts-alsa" && myaudio="$myaudio,alsa" || myconf="$myconf --without-alsa --disable-alsa"
use nas		&& myaudio="$myaudio,nas --with-nas-library=/usr/X11R6/lib/libaudio.so --with-nas-includes=/usr/X11R6/include" || myconf="$myconf --disable-nas"
use esd		&& myaudio="$myaudio,esd"			|| myconf="$myconf --disable-esd"
use motif	&& myinterface="$myinterface,motif" && myconf="$myconf --enable-motif"
use slang	&& myinterface="$myinterface,slang" && myconf="$myconf --enable-slang"
use tcltk	&& myinterface="$myinterface,tcltk" && myconf="$myconf --enable-tcltk"
use oggvorbis	&& myconf="$myconf --with-vorbis=/usr"		|| myconf="$myconf --without-vorbis"

myconf="$myconf $myaudio $myinterface --with-cdda --disable-strict --disable-warnings"

src_unpack()
{
	kde_src_unpack
	epatch ${FILESDIR}/flac-patch.diff
}
