# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/helixplayer/helixplayer-1.0_beta1.ebuild,v 1.4 2004/11/17 23:56:12 chriswhite Exp $

inherit nsplugins eutils

DESCRIPTION="A free open-source media player by real"
HOMEPAGE="http://www.helixplayer.org/"
SRC_URI="https://helixcommunity.org/download.php/487/${P}-beta-source.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
# -sparc -amd64: 1.0_beta1: build fails on both platforms... --eradicator
KEYWORDS="~x86 -sparc -amd64"
IUSE="mozilla"
DEPEND="media-libs/libtheora
		media-libs/libogg"
RDEPEND=">=dev-libs/glib-2
		>=x11-libs/pango-1.2
		>=x11-libs/gtk+-2.2"

# Had to change the source directory because of this somewhat
# non-standard naming convention
S=${WORKDIR}/player_all-bingo-beta-20040615

src_unpack() {

	unpack ${A}
	cd ${S}

	#fixes gcc version checking with non C based locales
	epatch ${FILESDIR}/gcc_versioncheck.patch

	#fixes the .bif file to create a gentoo_player custom target
	epatch ${FILESDIR}/${P}-bif.patch

	#fixes the strange tarball name that gets created
	epatch ${FILESDIR}/installer-naming.patch
}

src_compile() {

	#copies our buildrc file over with information on where
	#ogg and theora libs are kept
	cp ${FILESDIR}/buildrc ${S}

	export BUILDRC="${S}/buildrc"
	export BUILD_ROOT="${S}/build"

	#now we can begin the build
	${S}/build/bin/build -m bingo-beta -trelease -k -P helix-client-all-defines-free player_gentoo || die
}

src_install() {

	#you're probably thinking "what on earth is he doing?!"
	#well.. you're right
	#the fact is.. the only way to get the directory structure helixplayer uses
	#is to use their archive installer, unpack it, then copy all the files over
	#This will be fixed soon.. don't worry :)
	mkdir ${S}/release/HelixPlayer
	tar -jxf ${S}/release/helixplayer.tar.bz2 -C ${S}/release/HelixPlayer

	#Ok, now that that little hack is over with ;)
	if use mozilla ; then
		cd ${S}/release/HelixPlayer/mozilla
		exeinto /opt/netscape/plugins
		doexe nphelix.so
		inst_plugin /opt/netscape/plugins/nphelix.so
	fi

	cd ${S}/release/HelixPlayer/codecs
	insinto /opt/HelixPlayer/codecs
	insopts -m755
	doins *

	cd ${S}/release/HelixPlayer/common
	insinto /opt/HelixPlayer/common
	insopts -m755
	doins *

	cd ${S}/release/HelixPlayer/doc
	insinto /opt/HelixPlayer/doc
	doins *

	cd ${S}/release/HelixPlayer/lib
	insinto /opt/HelixPlayer/lib
	insopts -m755
	doins *

	cd ${S}/release/HelixPlayer/plugins
	insinto /opt/HelixPlayer/plugins
	insopts -m755
	doins *

	cd ${S}/release/HelixPlayer/share
	insinto /opt/HelixPlayer/share
	doins *

	cd ${S}/release/HelixPlayer/share/default
	insinto /opt/HelixPlayer/share/default
	insopts -m644
	doins *

	cd ${S}/release/HelixPlayer/share/hxplay
	insinto /opt/HelixPlayer/share/hxplay
	insopts -m644
	doins *

	cd ${S}/release/HelixPlayer/share/icons
	insinto /opt/HelixPlayer/share/icons
	insopts -m644
	doins *

	cd ${S}/release/HelixPlayer/share/locale
	insinto /opt/HelixPlayer/share/locale
	insopts -m755
	doins *

	cd ${S}/release/HelixPlayer/
	insinto /opt/HelixPlayer
	insopts -m755
	doins hxplay hxplay.bin
	insopts -m644
	doins LICENSE README

	insinto /etc/env.d
	insopts -m644
	doins ${FILESDIR}/50helix
}
