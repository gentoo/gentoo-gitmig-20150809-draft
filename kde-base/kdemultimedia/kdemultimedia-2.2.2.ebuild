# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia/kdemultimedia-2.2.2.ebuild,v 1.12 2002/08/01 11:40:15 seemant Exp $
inherit kde-dist

DESCRIPTION="KDE $PV - multimedia apps"
KEYWORDS="x86"

newdepend ">=sys-libs/ncurses-5.2
    >=media-sound/cdparanoia-3.9.8
    >=media-libs/libvorbis-1.0_beta4
	>=media-video/xanim-2.80.1
	alsa? ( >=media-libs/alsa-lib-0.5.9 )
	nas? ( >=media-libs/nas-1.4.1 )
	esd? ( >=media-sound/esound-0.2.22 )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	gtk? ( =x11-libs/gtk+-1.2* )
	slang? ( >=sys-libs/slang-1.4.4 )"

src_unpack() {

    base_src_unpack all patch
    
}

src_compile() {

	kde_src_compile myconf

	local myaudio
	local myinteface
	myaudio="--enable-audio=oss"
	myinterface="--enable-interface=xaw,ncurses"

	use alsa	&& myconf="$myconf --with-alsa" && myaudio="$myaudio,alsa"
	use nas		&& myaudio="$myaudio,nas"
	use esd		&& myaudio="$myaudio,esd"
	use motif	&& myinterface="$myinterface,motif"
	use gtk		&& myinterface="$myinterface,gtk"
	use slang	&& myinterface="$myinterface,slang"
# tcl tk does not work

	myconf="$myconf $myaudio $myinterface"

	kde_src_compile configure make

}


