# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia/kdemultimedia-2.2.1-r1.ebuild,v 1.2 2001/10/01 11:04:22 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-dist || die

DESCRIPTION="${DESCRIPTION}Multimedia"

NEWDEPEND=">=sys-libs/ncurses-5.2
        >=media-sound/cdparanoia-3.9.8
        >=media-libs/libvorbis-1.0_beta4
	alsa? ( >=media-libs/alsa-lib-0.5.9 )
	nas? ( >=media-sound/nas-1.4.1 )
	esd? ( >=media-sound/esound-0.2.22 )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	gtk? ( >=x11-libs/gtk+-1.2.10 )
	slang? ( >=sys-libs/slang-1.4.4 )"
#	tcltk? ( =dev-lang/tcl-tk.8.0.5-r2 )

DEPEND="$DEPEND $NEWDEPEND"
RDEPEND="$RDEPEND $NEWDEPEND"

src_unpack() {

	base_src_unpack unpack
	cd ${S}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff

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
# tcl tk does not work: use tcltk	&& myinterface="$myinterface,tcltk"

	./configure --host=${CHOST} \
		--with-xinerama \
		$myconf $myaudio $myinterface || die

	kde_src_compile make

}


