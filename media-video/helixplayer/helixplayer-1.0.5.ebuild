# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/helixplayer/helixplayer-1.0.5.ebuild,v 1.1 2005/06/24 22:08:54 flameeyes Exp $

inherit nsplugins eutils

MY_PKG=${P/helixplayer/hxplay}

PATCHLEVEL="1"
DESCRIPTION="A free open-source media player by real"
HOMEPAGE="http://www.helixplayer.org/"
SRC_URI="https://helixcommunity.org/download.php/1340/${MY_PKG}.tar.bz2
	http://digilander.libero.it/dgp85/gentoo/${PN}-patches-${PATCHLEVEL}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
# -sparc -amd64: 1.0_beta1: build fails on both platforms... --eradicator
KEYWORDS="-*"
IUSE="mozilla nptl"
DEPEND="media-libs/libtheora
	media-libs/libogg"
RDEPEND=">=dev-libs/glib-2
	>=x11-libs/pango-1.2
	>=x11-libs/gtk+-2.2"

# Had to change the source directory because of this somewhat
# non-standard naming convention
S=${WORKDIR}/${MY_PKG}

src_unpack() {
	unpack ${A}
	cd ${S}

	use nptl || EPATCH_EXCLUDE="03_all_sem-t.patch"
	EPATCH_SUFFIX="patch" epatch ${WORKDIR}/1.0.4

	#fixes icon name in .desktop file
	sed -i -e 's:hxplay.png:hxplay:' ${S}/player/installer/common/hxplay.desktop
}

src_compile() {

	#copies our buildrc file over with information on where
	#ogg and theora libs are kept
	cp ${WORKDIR}/1.0.4/buildrc ${S}

	export BUILDRC="${S}/buildrc"
	export BUILD_ROOT="${S}/build"

	#now we can begin the build
	${S}/build/bin/build -m hxplay_gtk_release -trelease -k -P helix-client-all-defines-free player_gentoo || die
}

src_install() {

	# install the tarballed installation into
	# the /opt directory
	keepdir /opt/HelixPlayer
	tar -jxf ${S}/release/helixplayer.tar.bz2 -C ${D}/opt/HelixPlayer

	if use mozilla ; then
		cd ${D}/opt/HelixPlayer/mozilla
		exeinto /opt/netscape/plugins
		doexe nphelix.so
		inst_plugin /opt/netscape/plugins/nphelix.so
	fi

	doenvd ${WORKDIR}/1.0.4/50helix

	for res in 16 192 32 48; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps
		newins ${S}/player/app/gtk/res/icons/hxplay/hxplay_${res}x${res}.png \
				hxplay.png
	done

	domenu ${S}/player/installer/common/hxplay.desktop

	# Remove setup script as it's dangerous, and the directory if it's empty
	rm -rf ${D}/opt/HelixPlayer/Bin/setup
	rm -f ${D}/opt/HelixPlayer/Bin
}
