# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/helixplayer/helixplayer-1.0.3.ebuild,v 1.1 2005/03/27 06:21:38 chriswhite Exp $

inherit nsplugins eutils

MY_PKG=${P/helixplayer/hxplay}

DESCRIPTION="A free open-source media player by real"
HOMEPAGE="http://www.helixplayer.org/"
SRC_URI="https://helixcommunity.org/download.php/970/${MY_PKG}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
# -sparc -amd64: 1.0_beta1: build fails on both platforms... --eradicator
KEYWORDS="~x86 -sparc -amd64"
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

	#adjust strange naming for helixplayer tarball
	epatch ${FILESDIR}/installer-naming.patch

	#fixes the .bif file to create a gentoo_player custom target
	epatch ${FILESDIR}/${P}-bif.patch

	#fixes sem_t based issues
	use nptl && epatch ${FILESDIR}/${P}-sem_t.patch
}

src_compile() {

	#copies our buildrc file over with information on where
	#ogg and theora libs are kept
	cp ${FILESDIR}/buildrc ${S}

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

	doenvd ${FILESDIR}/50helix
}
