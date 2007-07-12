# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mplayer-skins/mplayer-skins-0.2-r5.ebuild,v 1.3 2007/07/12 07:35:24 mr_bones_ Exp $

S=${WORKDIR}
DESCRIPTION="Collection of mplayer themes"
HOMEPAGE="http://www.mplayerhq.hu/"
THEME_URI="http://www1.mplayerhq.hu/MPlayer/Skin/"
SRC_URI="${THEME_URI}Abyss-1.1.tar.bz2
${THEME_URI}AlienMind-1.2.tar.bz2
${THEME_URI}Blue-1.5.tar.bz2
${THEME_URI}Blue-small-1.2.tar.bz2
${THEME_URI}BlueHeart-1.5.tar.bz2
${THEME_URI}Canary-1.2.tar.bz2
${THEME_URI}Corelian-1.1.tar.bz2
${THEME_URI}CornerMP-1.2.tar.bz2
${THEME_URI}CornerMP-aqua-1.4.tar.bz2
${THEME_URI}CubicPlayer-1.1.tar.bz2
${THEME_URI}Cyrus-1.2.tar.bz2
${THEME_URI}DVDPlayer-1.1.tar.bz2
${THEME_URI}Dushku-1.2.tar.bz2
${THEME_URI}Industrial-1.0.tar.bz2
${THEME_URI}JiMPlayer-1.4.tar.bz2
${THEME_URI}KDE-0.3.tar.bz2
${THEME_URI}Linea-1.0.tar.bz2
${THEME_URI}MidnightLove-1.6.tar.bz2
${THEME_URI}OSX-Brushed-2.3.tar.bz2
${THEME_URI}OSX-Mod-1.1.tar.bz2
${THEME_URI}OpenDoh-1.1.tar.bz2
${THEME_URI}Orange-1.3.tar.bz2
${THEME_URI}PowerPlayer-1.1.tar.bz2
${THEME_URI}QPlayer-1.2.tar.bz2
${THEME_URI}QuickSilver-1.0.tar.bz2
${THEME_URI}Terminator3-1.1.tar.bz2
${THEME_URI}WMP6-2.2.tar.bz2
${THEME_URI}XFce4-1.0.tar.bz2
${THEME_URI}avifile-1.6.tar.bz2
${THEME_URI}bluecurve-1.3.tar.bz2
${THEME_URI}brushedGnome-1.0.tar.bz2
${THEME_URI}changuito-0.2.tar.bz2
${THEME_URI}clearplayer-0.8.tar.bz2
${THEME_URI}disappearer-1.1.tar.bz2
${THEME_URI}divxplayer-1.3.tar.bz2
${THEME_URI}gnome-1.1.tar.bz2
${THEME_URI}handheld-1.0.tar.bz2
${THEME_URI}hayraphon-1.0.tar.bz2
${THEME_URI}hwswskin-1.1.tar.bz2
${THEME_URI}iTunes-1.1.tar.bz2
${THEME_URI}iTunes-mini-1.1.tar.bz2
${THEME_URI}krystal-1.1.tar.bz2
${THEME_URI}mentalic-1.2.tar.bz2
${THEME_URI}mini-0.1.tar.bz2
${THEME_URI}moonphase-1.0.tar.bz2
${THEME_URI}mplayer_red-1.0.tar.bz2
${THEME_URI}netscape4-1.0.tar.bz2
${THEME_URI}neutron-1.5.tar.bz2
${THEME_URI}new-age-1.0.tar.bz2
${THEME_URI}phony-1.1.tar.bz2
${THEME_URI}plastic-1.2.tar.bz2
${THEME_URI}plastik-2.0.tar.bz2
${THEME_URI}productive-1.0.tar.bz2
${THEME_URI}proton-1.2.tar.bz2
${THEME_URI}sessene-1.0.tar.bz2
${THEME_URI}slim-1.2.tar.bz2
${THEME_URI}smoothwebby-1.0.tar.bz2
${THEME_URI}softgrip-1.1.tar.bz2
${THEME_URI}standard-1.9.tar.bz2
${THEME_URI}trium-1.3.tar.bz2
${THEME_URI}tvisor-1.1.tar.bz2
${THEME_URI}ultrafina-1.1.tar.bz2
${THEME_URI}webby-1.2.tar.bz2
${THEME_URI}xanim-1.6.tar.bz2
${THEME_URI}xine-lcd-1.2.tar.bz2
${THEME_URI}xmmplayer-1.5.tar.bz2"

SLOT="0"
LICENSE="freedist"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND=""
RDEPEND="media-video/mplayer"

src_install () {
	dodir /usr/share/mplayer/skins
	cp -R * ${D}/usr/share/mplayer/skins/
	chown -R root:0 ${D}/usr/share/mplayer/skins/
	chmod -R o-w ${D}/usr/share/mplayer/skins/
	chmod -R a+rX ${D}/usr/share/mplayer/skins/
}
