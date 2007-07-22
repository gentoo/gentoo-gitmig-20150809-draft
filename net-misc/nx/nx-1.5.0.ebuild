# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nx/nx-1.5.0.ebuild,v 1.3 2007/07/22 08:01:53 dberkholz Exp $

inherit eutils

DESCRIPTION="A special version of the X11 libraries supporting NX compression technology"
HOMEPAGE="http://www.nomachine.com/developers.php"

URI_BASE="http://web04.nomachine.com/download/1.5.0/sources"
SRC_NX_X11="nx-X11-$PV-21.tar.gz"
SRC_NXAGENT="nxagent-$PV-112.tar.gz"
SRC_NXAUTH="nxauth-$PV-1.tar.gz"
SRC_NXCOMP="nxcomp-$PV-80.tar.gz"
SRC_NXCOMPEXT="nxcompext-$PV-20.tar.gz"
SRC_NXDESKTOP="nxdesktop-$PV-78.tar.gz"
SRC_NXVIEWER="nxviewer-$PV-15.tar.gz"
SRC_NXPROXY="nxproxy-$PV-9.tar.gz"

SRC_URI="$URI_BASE/$SRC_NX_X11 $URI_BASE/$SRC_NXAGENT $URI_BASE/$SRC_NXPROXY
	$URI_BASE/$SRC_NXAUTH $URI_BASE/$SRC_NXCOMPEXT $URI_BASE/$SRC_NXCOMP
	rdesktop? ( $URI_BASE/$SRC_NXDESKTOP )
	vnc? ( $URI_BASE/$SRC_NXVIEWER )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="rdesktop vnc"

RDEPEND="x11-libs/libX11
		x11-libs/libFS
		x11-libs/libXvMC
		x11-libs/libICE
		x11-libs/libXmu
		x11-libs/libXdmcp
		x11-libs/libSM
		x11-libs/libXt
		x11-libs/libXau
		x11-libs/libXaw
		x11-libs/libXp
		x11-libs/libXpm
		x11-libs/libXext
		dev-libs/openssl
		media-libs/mesa
		>=media-libs/jpeg-6b-r4
		>=media-libs/libpng-1.2.8
		>=sys-libs/zlib-1.2.3
		virtual/libc"

DEPEND="${RDEPEND}
		x11-proto/xproto
		x11-proto/xf86vidmodeproto
		x11-proto/glproto
		x11-proto/videoproto
		x11-proto/xextproto
		x11-proto/fontsproto
		x11-misc/gccmakedep
		x11-misc/imake
		app-text/rman
		"
S=${WORKDIR}/${PN//x11/X11}

src_unpack() {
	# we can't use ${A} because of bug #61977
	unpack ${SRC_NX_X11}
	unpack ${SRC_NXAGENT}
	unpack ${SRC_NXAUTH}
	unpack ${SRC_NXCOMPEXT}
	unpack ${SRC_NXCOMP}
	unpack ${SRC_NXPROXY}
	use rdesktop && unpack ${SRC_NXDESKTOP}
	use vnc && unpack ${SRC_NXVIEWER}

	cd ${S}
	epatch ${FILESDIR}/1.5.0/nx-x11-windows-linux-resume.patch
	epatch ${FILESDIR}/1.5.0/nx-x11-1.5.0-plastik-render-fix.patch
	epatch ${FILESDIR}/1.5.0/nx-x11-1.5.0-xorg7-font-fix.patch
	epatch ${FILESDIR}/1.5.0/nx-x11-1.5.0-tmp-exec.patch
	epatch ${FILESDIR}/1.5.0/nx-x11-1.5.0-amd64.patch

	cd ${WORKDIR}/nxcomp
	epatch ${FILESDIR}/1.5.0/nxcomp-1.5.0-pic.patch
	epatch ${FILESDIR}/1.5.0/nxcomp-1.5.0-gcc4.patch
}

src_compile() {
	cd ${WORKDIR}/nxcomp || die
	./configure || die
	emake || die

	cd ${WORKDIR}/nxproxy || die
	./configure || die
	emake || die

	cd ${WORKDIR}/nx-X11 || die
	emake World || die

	cd ${WORKDIR}/nxcompext || die
	./configure || die
	emake || die

	if use vnc ; then
		cd ${WORKDIR}/nxviewer || die
		xmkmf -a || die
		emake World || die
	fi

	if use rdesktop ; then
		cd ${WORKDIR}/nxdesktop || die
		./configure || die
		emake || die
	fi
}

src_install() {
	newbin ${FILESDIR}/1.5.0/nxwrapper nxagent || die
	newbin ${FILESDIR}/1.5.0/nxwrapper nxauth  || die
	newbin ${FILESDIR}/1.5.0/nxwrapper nxproxy || die
	if use vnc ; then
		newbin ${FILESDIR}/1.5.0/nxwrapper nxviewer || die
		newbin ${FILESDIR}/1.5.0/nxwrapper nxpasswd || die
	fi
	if use rdesktop ; then
		newbin ${FILESDIR}/1.5.0/nxwrapper nxdesktop || die
	fi

	into /usr/lib/NX
	dobin ${WORKDIR}/nx-X11/programs/Xserver/nxagent || die
	dobin ${WORKDIR}/nx-X11/programs/nxauth/nxauth || die
	dobin ${WORKDIR}/nxproxy/nxproxy || die

	if use vnc ; then
		dobin ${WORKDIR}/nxviewer/nxviewer/nxviewer || die
		dobin ${WORKDIR}/nxviewer/nxpasswd/nxpasswd || die
	fi

	if use rdesktop ; then
		dobin ${WORKDIR}/nxdesktop/nxdesktop || die
	fi

	dolib.so ${WORKDIR}/nx-X11/lib/X11/libX11.so* || die
	dolib.so ${WORKDIR}/nx-X11/lib/Xext/libXext.so* || die
	dolib.so ${WORKDIR}/nx-X11/lib/Xrender/libXrender.so* || die
	dolib.so ${WORKDIR}/nxcomp/libXcomp.so* || die
	dolib.so ${WORKDIR}/nxcompext/libXcompext.so* || die
}
