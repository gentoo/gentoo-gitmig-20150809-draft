# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mplayer-skins/mplayer-skins-0.1.ebuild,v 1.4 2003/09/04 05:14:22 msterret Exp $

S=${WORKDIR}
DESCRIPTION="Collection of mplayer themes"
HOMEPAGE="http://www.mplayerhq.hu/"
THEME_URI="http://www.mplayerhq.hu/MPlayer/Skin"
SRC_URI="${THEME_URI}/AlienMind.tar.bz2
	 ${THEME_URI}/BlueHeart.tar.bz2
	 ${THEME_URI}/CornerMP-aqua.tar.bz2
	 ${THEME_URI}/CornerMP.tar.bz2
	 ${THEME_URI}/CubicPlayer.tar.bz2
	 ${THEME_URI}/Cyrus.tar.bz2
	 ${THEME_URI}/MidnightLove.tar.bz2
	 ${THEME_URI}/WindowsMediaPlayer6.tar.bz2
	 ${THEME_URI}/avifile.tar.bz2
	 ${THEME_URI}/gnome.tar.bz2
	 ${THEME_URI}/hwswskin.tar.bz2
	 ${THEME_URI}/mentalic.tar.bz2
	 ${THEME_URI}/netscape4.tar.bz2
	 ${THEME_URI}/neutron.tar.bz2
	 ${THEME_URI}/phony.tar.bz2
	 ${THEME_URI}/plastic.tar.bz2
	 ${THEME_URI}/proton.tar.bz2
	 ${THEME_URI}/slim.tar.bz2
	 ${THEME_URI}/trium.tar.bz2
	 ${THEME_URI}/xanim.tar.bz2
	 ${THEME_URI}/xine-lcd.tar.bz2"
#	${THEME_URI}/default.tar.bz2

SLOT="0"
LICENSE="freedist"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="net-misc/wget"
RDEPEND="media-video/mplayer
	 sys-apps/bzip2"

#src_unpack() {
#	local bn
#	mkdir ${S}
#	cd ${S}
#	for i in ${SRC_URI} ; do
#		bn=`basename $i`
#		unpack ${bn}
#	done
#}

src_install () {
	dodir /usr/share/mplayer/Skin
	cp -dR * ${D}/usr/share/mplayer/Skin/
	chown -R root.root ${D}/usr/share/mplayer/Skin/
	chmod -R o-w ${D}/usr/share/mplayer/Skin/
	chmod -R a+rX ${D}/usr/share/mplayer/Skin/
}
