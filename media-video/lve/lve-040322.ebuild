# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/lve/lve-040322.ebuild,v 1.5 2004/06/25 00:44:15 agriffis Exp $

inherit eutils

# This is the version of ffmpeg lve must currently be compiled against
FFMPEG="ffmpeg-0.4.8"

DESCRIPTION="Linux Video Editor"
HOMEPAGE="http://lvempeg.sourceforge.net"
SRC_URI="http://heanet.dl.sourceforge.net/sourceforge/lvempeg/lve-040322.src.tar.bz2
http://heanet.dl.sourceforge.net/sourceforge/ffmpeg/ffmpeg-0.4.8.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
DEPEND="virtual/x11
	>=media-libs/libsdl-1.2.6-r3
	>=x11-libs/qt-3.3.0-r1"


src_unpack() {
	unpack ${AA}

	# Patch to change location of qt library
	epatch ${FILESDIR}/${PV}-qtlib.patch

	# Patch to change LIB and BIN paths
	epatch ${FILESDIR}/${PV}-lve.patch
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
