# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/lve/lve-040322.ebuild,v 1.8 2004/09/05 18:06:43 malc Exp $

inherit eutils gcc

# This is the version of ffmpeg lve must currently be compiled against
FFMPEG="ffmpeg-0.4.8"
PDATE=20${PV##*.}

DESCRIPTION="Linux Video Editor"
HOMEPAGE="http://lvempeg.sourceforge.net"
SRC_URI="mirror://sourceforge/lvempeg/lve-040322.src.tar.bz2
	http://download.videolan.org/pub/videolan/vlc/0.7.1/contrib/ffmpeg-${PDATE}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc ~amd64"
DEPEND="virtual/x11
	>=media-libs/libsdl-1.2.6-r3
	>=x11-libs/qt-3.3.0-r1"


src_unpack() {
	unpack ${AA}

	# Patch to change location of qt library
	epatch ${FILESDIR}/${PV}-qtlib.patch

	# Patch to change LIB and BIN paths
	epatch ${FILESDIR}/${PV}-lve.patch

	cd ${WORKDIR}/lve

	rm ffmpeg
	ln -s ../ffmpeg-20040322 ffmpeg

	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "4" ]
	then
		einfo "Compiler used: gcc-3.4.x Applying patch conditionally."
		sed -i "s:(T_REGION \*):T_REGION \*:" src/region.c || die "Source couldnt be fixed"
		cd ffmpeg
		epatch ${FILESDIR}/0.4.8-gcc3.4-magicF2W.patch
		cd ${WORKDIR}/lve
	fi
}

src_compile() {
	cd ${WORKDIR}/lve

	make || die
}

src_install() {
	# Install bitmaps
	dodir /usr/share/pixmaps/lve
	insinto /usr/share/pixmaps/lve
	doins ${WORKDIR}/lve/lib/*

	# Install binaries
	dodir /usr/bin
	insopts -m0755
	insinto /usr/bin
	doins ${WORKDIR}/lve/bin/*
	doins  ${WORKDIR}/lve/qdir/qdir
}
