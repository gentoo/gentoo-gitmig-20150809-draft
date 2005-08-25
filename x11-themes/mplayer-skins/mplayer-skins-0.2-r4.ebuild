# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mplayer-skins/mplayer-skins-0.2-r4.ebuild,v 1.7 2005/08/25 18:11:35 agriffis Exp $

S=${WORKDIR}
DESCRIPTION="Collection of mplayer themes"
HOMEPAGE="http://www.mplayerhq.hu/"
THEME_URI="http://www1.mplayerhq.hu/MPlayer/Skin/"
SRC_URI="${THEME_URI}/AlienMind-1.1.tar.bz2
	${THEME_URI}/Blue-small-1.0.tar.bz2
	${THEME_URI}/BlueHeart-1.4.tar.bz2
	${THEME_URI}/CornerMP-aqua-1.0.tar.bz2
	${THEME_URI}/CornerMP-1.0.tar.bz2
	${THEME_URI}/Cyrus-1.0.tar.bz2
	${THEME_URI}/MidnightLove-1.5.tar.bz2
	${THEME_URI}/Orange-1.1.tar.bz2
	${THEME_URI}/QPlayer-1.0.3.tar.bz2
	${THEME_URI}/WindowsMediaPlayer6-1.2.tar.bz2
	${THEME_URI}/avifile-1.5.tar.bz2
	${THEME_URI}/disappearer-1.1.tar.bz2
	${THEME_URI}/gnome-1.1.tar.bz2
	${THEME_URI}/hayraphon-1.0.tar.bz2
	${THEME_URI}/hwswskin-1.0.tar.bz2
	${THEME_URI}/krystal-1.0.tar.bz2
	${THEME_URI}/mentalic-1.1.tar.bz2
	${THEME_URI}/neutron-1.4.tar.bz2
	${THEME_URI}/phony-1.0.tar.bz2
	${THEME_URI}/plastic-1.1.1.tar.bz2
	${THEME_URI}/proton-1.1.tar.bz2
	${THEME_URI}/slim-1.0.tar.bz2
	${THEME_URI}/softgrip-1.0.tar.bz2
	${THEME_URI}/trium-1.1.tar.bz2
	${THEME_URI}/xanim-1.5.tar.bz2
	${THEME_URI}/xine-lcd-1.0.tar.bz2
	${THEME_URI}/Corelian-1.0.tar.bz2
	${THEME_URI}/DVDPlayer-1.0.tar.bz2
	${THEME_URI}/OSX-Brushed-2.2.tar.bz2
	${THEME_URI}/Terminator3-1.0.tar.bz2
	${THEME_URI}/divxplayer-1.2.tar.bz2
	${THEME_URI}/iTunes-1.1.tar.bz2
	${THEME_URI}/iTunes-mini-1.1.tar.bz2
	${THEME_URI}/mplayer_red-1.0.tar.bz2
	${THEME_URI}/xmmplayer-1.0.tar.bz2"


SLOT="0"
LICENSE="freedist"
KEYWORDS="~alpha ~amd64 ia64 ppc ~sparc ~x86"
IUSE=""

DEPEND="net-misc/wget"
RDEPEND="media-video/mplayer
	 app-arch/bzip2"

src_install () {
	dodir /usr/share/mplayer/Skin
	cp -R * ${D}/usr/share/mplayer/Skin/
	chown -R root:0 ${D}/usr/share/mplayer/Skin/
	chmod -R o-w ${D}/usr/share/mplayer/Skin/
	chmod -R a+rX ${D}/usr/share/mplayer/Skin/
}
