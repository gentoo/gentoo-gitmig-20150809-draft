# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia/kdemultimedia-3.0.5b.ebuild,v 1.5 2004/02/16 01:15:47 caleb Exp $
inherit kde-dist flag-o-matic eutils

IUSE="nas esd motif gtk slang tcltk"
DESCRIPTION="KDE $PV - multimedia apps"
KEYWORDS="x86 ppc ~alpha sparc"

newdepend ">=sys-libs/ncurses-5.2
	>=media-sound/cdparanoia-3.9.8
	>=media-libs/libvorbis-1.0_beta4
	>=media-video/xanim-2.80.1
	nas? ( >=media-libs/nas-1.4.1 )
	esd? ( >=media-sound/esound-0.2.22 )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	gtk? ( =x11-libs/gtk+-1.2* )
	slang? ( >=sys-libs/slang-1.4.4 )
	virtual/mpg123
	tcltk? ( >=dev-lang/tk-8.0.5-r2 )"
#	alsa? ( >=media-libs/alsa-lib-0.5.9 )"

# koncd isn't compiled by default (kde.org's default)
#RDEPEND="$RDEPEND
#	cdr? ( app-cdr/cdrtools
#	>=app-cdr/cdrdao-1.1.5 )"

replace-flags "-O3" "-O2"
filter-flags "-fforce-addr -fomit-frame-pointer"

myaudio="--enable-audio=oss"
myinterface="--enable-interface=xaw,ncurses"
myconf="$myconf --enable-xaw --enable-ncurses"

#use alsa	&& myconf="$myconf --with-alsa --with-arts-alsa" && myaudio="$myaudio,alsa" ||
myconf="$myconf --without-alsa --disable-alsa"
use nas		&& myaudio="$myaudio,nas --with-nas-library=/usr/X11R6/lib/libaudio.so --with-nas-includes=/usr/X11R6/include" || myconf="$myconf --disable-nas"
use esd		&& myaudio="$myaudio,esd"					|| myconf="$myconf --disable-esd"
use motif	&& myinterface="$myinterface,motif" && myconf="$myconf --enable-motif"
use gtk		&& myinterface="$myinterface,gtk"   && myconf="$myconf --enable-gtk"
use slang	&& myinterface="$myinterface,slang" && myconf="$myconf --enable-slang"
use tcltk	&& myinterface="$myinterface,tcltk" && myconf="$myconf --enable-tcltk"

myconf="$myconf $myaudio $myinterface"

#use cdr		|| KDE_REMOVE_DIR="koncd"

src_unpack() {
	kde_src_unpack
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo-timidity.diff
	#use alsa && patch -p0 < ${FILESDIR}/${P}-gentoo-alsa.diff

	kde_sandbox_patch ${S}/kmidi/config

	cd ${S}/kmidi/config
	for x in Makefile.am Makefile.in; do
		mv $x $x.orig
		sed -e 's:TIMID_DIR = $(DESTDIR)/$(kde_datadir):TIMID_DIR = $(kde_datadir):g' $x.orig > $x
	done
}

pkg_postinst() {
	if [ -n "`use alsa`" ]; then
	einfo "WARNING: alsa support has been removed becuase of a bug in kdemm sources.
For further information see bug #2324 on bugs.gentoo.org and bug #39574 on bugs.kde.org.
Meanwhile, you can use the alsa oss emulation."
	fi
}
