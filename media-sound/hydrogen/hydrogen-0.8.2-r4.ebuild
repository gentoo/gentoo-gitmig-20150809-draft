# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/hydrogen/hydrogen-0.8.2-r4.ebuild,v 1.2 2004/07/26 21:59:18 eradicator Exp $

inherit eutils

DESCRIPTION="Linux Drum Machine"
HOMEPAGE="http://hydrogen.sourceforge.net/"
SRC_URI="mirror://sourceforge/hydrogen/${P}.tar.gz \
	mirror://sourceforge/hydrogen/3355606.tar.gz \
	mirror://sourceforge/hydrogen/DrumkitPack1.tar.gz \
	mirror://sourceforge/hydrogen/DrumkitPack2.tar.gz \
	mirror://sourceforge/hydrogen/EasternHop-1.tar.gz \
	mirror://sourceforge/hydrogen/TD-7.tar.gz \
	mirror://sourceforge/hydrogen/UltraAcousticKit.tar.gz \
	mirror://sourceforge/hydrogen/Millo-Drums_v1.tar.gz \
	mirror://sourceforge/hydrogen/HardElectro1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"

IUSE="alsa jack"


RDEPEND="virtual/x11
	>=media-libs/audiofile-0.2.3 \
	alsa? ( media-libs/alsa-lib ) \
	jack? ( media-sound/jack-audio-connection-kit ) \
	>=x11-libs/qt-3"

DEPEND="$RDEPEND >=sys-devel/autoconf-2.58"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-ui-spacer.patch
	epatch ${FILESDIR}/${P}-64bit.patch
	epatch ${FILESDIR}/${P}-gcc34.patch

	# unpack drum kits
	cd ${P}/data/drumkits
	tar zxf ${WORKDIR}/3355606/3355606kit.h2drumkit
	tar zxf ${WORKDIR}/DrumkitPack1/HipHop-1.h2drumkit
	tar zxf ${WORKDIR}/DrumkitPack1/HipHop-2.h2drumkit
	tar zxf ${WORKDIR}/DrumkitPack2/Synthie-1.h2drumkit
	tar zxf ${WORKDIR}/DrumkitPack2/TR808909.h2drumkit
	tar zxf ${WORKDIR}/DrumkitPack2/Techno-1.h2drumkit
	tar zxf ${WORKDIR}/EasternHop-1/EasternHop-1.h2drumkit
	tar zxf ${WORKDIR}/EasternHop-1/EasternHop-1.h2drumkit
	tar zxf ${WORKDIR}/TD-7/TD-7kit.h2drumkit
	tar zxf ${WORKDIR}/UltraAcousticKit/UltraAcousticKit.h2drumkit
	tar zxf ${WORKDIR}/Millo-Drums_v1/Millo-Drums_v.1.h2drumkit
	tar zxf ${WORKDIR}/HardElectro1/HardElectro1.h2drumkit

	# unpack demo songs
	# (note that some songs are disabled due to incompatibility with this (newer?) version of hydrogen...)
	cd ../demo_songs
	#cp ${WORKDIR}/3355606/*.h2song .
	#cp ${WORKDIR}/DrumkitPack1/*.h2song .
	#cp ${WORKDIR}/DrumkitPack2/*.h2song .
	#cp ${WORKDIR}/EasternHop-1/*.h2song .
	#cp ${WORKDIR}/TD-7/*.h2song .
	cp ${WORKDIR}/UltraAcousticKit/*.h2song .
	cp ${WORKDIR}/Millo-Drums_v1/demo\ songs/*.h2song .
	cp ${WORKDIR}/HardElectro1/*.h2song .

	# fix file paths
	for SONG in `ls *.h2song`; do
		sed -i -e "s:/usr/local/share:/usr/share:" ${SONG}
	done
}

src_compile() {
	addwrite ${QTDIR}/etc/settings

	einfo "Reconfiguring..."
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.6

	./autogen.sh

	econf || die
	emake || die
}

src_install() {
	local SUPPORTDIR=/usr/share/hydrogen

	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog README TODO

	# install demo songs
	insinto ${SUPPORTDIR}/data/demo_songs
	doins data/demo_songs/*

	# install drum kits
	for KIT in `find data/drumkits -type d`; do
		insinto ${SUPPORTDIR}/${KIT}
		doins ${KIT}/*.xml
		doins ${KIT}/*.wav
	done
}
