# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia/kdemultimedia-3.0.ebuild,v 1.4 2002/04/17 20:02:15 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-dist

DESCRIPTION="${DESCRIPTION}Multimedia"

newdepend ">=sys-libs/ncurses-5.2
	>=media-sound/cdparanoia-3.9.8
	>=media-libs/libvorbis-1.0_beta4
	>=media-video/xanim-2.80.1
	alsa? ( >=media-libs/alsa-lib-0.5.9 )
	nas? ( >=media-libs/nas-1.4.1 )
	esd? ( >=media-sound/esound-0.2.22 )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	gtk? ( >=x11-libs/gtk+-1.2.10-r4 )
	slang? ( >=sys-libs/slang-1.4.4 )
	app-cdr/cdrtools
	>=app-cdr/cdrdao-1.1.5
	>=media-sound/mpg123-0.59r
	tcltk? ( >=dev-lang/tcl-tk.8.0.5-r2 )"

src_unpack() {
    
    base_src_unpack
    cd ${S}
    patch -p0 < ${FILESDIR}/${P}-gentoo-timidity.diff
    use alsa && patch -p0 < ${FILESDIR}/${P}-gentoo-alsa.diff
    kde_sandbox_patch ${S}/kmidi/config    
    
}

src_compile() {

	kde_src_compile myconf

	local myaudio
	local myinteface
	myaudio="--enable-audio=oss"
	myinterface="--enable-interface=xaw,ncurses"
	myconf="$myconf --enable-xaw --enable-ncurses"

	use alsa	&& myconf="$myconf --with-alsa" && myaudio="$myaudio,alsa" 	|| myconf="$myconf --disable-alsa"
	use nas		&& myaudio="$myaudio,nas"					|| myconf="$myconf --disable-nas"
	use esd		&& myaudio="$myaudio,esd"					|| myconf="$myconf --disable-esd"
	use motif	&& myinterface="$myinterface,motif" && myconf="$myconf --enable-motif"
	use gtk		&& myinterface="$myinterface,gtk"   && myconf="$myconf --enable-gtk"
	use slang	&& myinterface="$myinterface,slang" && myconf="$myconf --enable-slang"
	use tcltk	&& myinterface="$myinterface,tcltk" && myconf="$myconf --enable-tcltk"
	#myconf="$myconf --disable-tcltk"

	myconf="$myconf $myaudio $myinterface"

	kde_src_compile configure make

}


