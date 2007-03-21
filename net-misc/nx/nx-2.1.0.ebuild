# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nx/nx-2.1.0.ebuild,v 1.1 2007/03/21 00:15:30 voyageur Exp $

inherit autotools eutils multilib

DESCRIPTION="NX compression technology core libraries"
HOMEPAGE="http://www.nomachine.com/developers.php"

URI_BASE="http://web04.nomachine.com/download/${PV}/sources"
SRC_NX_X11="nx-X11-$PV-3.tar.gz"
SRC_NXAGENT="nxagent-$PV-18.tar.gz"
SRC_NXAUTH="nxauth-$PV-2.tar.gz"
SRC_NXCOMP="nxcomp-$PV-8.tar.gz"
SRC_NXCOMPEXT="nxcompext-$PV-5.tar.gz"
SRC_NXDESKTOP="nxdesktop-$PV-9.tar.gz"
SRC_NXVIEWER="nxviewer-$PV-12.tar.gz"
SRC_NXPROXY="nxproxy-$PV-3.tar.gz"

SRC_URI="$URI_BASE/$SRC_NX_X11 $URI_BASE/$SRC_NXAGENT $URI_BASE/$SRC_NXPROXY
	$URI_BASE/$SRC_NXAUTH $URI_BASE/$SRC_NXCOMPEXT $URI_BASE/$SRC_NXCOMP
	rdesktop? ( $URI_BASE/$SRC_NXDESKTOP )
	vnc? ( $URI_BASE/$SRC_NXVIEWER )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="rdesktop vnc"

RDEPEND="x86? ( x11-libs/libXau
		   		x11-libs/libXdmcp
				x11-libs/libXpm
				>=media-libs/jpeg-6b-r4
				>=media-libs/libpng-1.2.8
				>=sys-libs/zlib-1.2.3 )
		 amd64? ( >=app-emulation/emul-linux-x86-xlibs-10.0 )"

DEPEND="${RDEPEND}
		x11-misc/gccmakedep
		x11-misc/imake
		!net-misc/nx-x11
		!net-misc/nx-x11-bin
		!net-misc/nxcomp
		!net-misc/nxproxy
		!net-misc/nxssh"

S=${WORKDIR}/${PN}-X11

src_unpack() {
	unpack ${A}

	cd ${WORKDIR}
	epatch ${FILESDIR}/1.5.0/nx-x11-1.5.0-tmp-exec.patch
	epatch ${FILESDIR}/1.5.0/nxcomp-1.5.0-pic.patch
	epatch ${FILESDIR}/${P}-nxagent-mem-leaks.patch

	cd ${WORKDIR}/nxcomp
	epatch ${FILESDIR}/${P}-deprecated-headers.patch
	epatch ${FILESDIR}/${P}-invalid-options.patch
	eautoreconf
}

src_compile() {
	# nx-X11 will only compile in 32-bit
	use amd64 && multilib_toolchain_setup x86

	cd ${WORKDIR}/nxcomp || die
	econf || die
	emake || die

	cd ${WORKDIR}/nxproxy || die
	econf || die
	emake || die

	cd ${WORKDIR}/nx-X11 || die
	emake World || die

	cd ${WORKDIR}/nxcompext || die
	econf || die
	emake || die

	if use vnc ; then
		cd ${WORKDIR}/nxviewer || die
		xmkmf -a || die
		emake World || die
	fi

	if use rdesktop ; then
		cd ${WORKDIR}/nxdesktop || die
		CC=(tc-getCC) ./configure || die
		emake || die
	fi
}

src_install() {
	NX_ROOT=/usr/$(get_libdir)/NX

	for x in nxagent nxauth nxproxy; do
		make_wrapper $x ./$x ${NX_ROOT}/bin ${NX_ROOT}/$(get_libdir) ||die
	done
	if use vnc ; then
		make_wrapper nxviewer ./nxviewer ${NX_ROOT}/bin ${NX_ROOT}/$(get_libdir) ||die
		make_wrapper nxpasswd ./nxpasswd ${NX_ROOT}/bin ${NX_ROOT}/$(get_libdir) ||die
	fi
	if use rdesktop ; then
		make_wrapper nxdesktop ./nxdesktop ${NX_ROOT}/bin ${NX_ROOT}/$(get_libdir) ||die
	fi

	into ${NX_ROOT}
	dobin ${WORKDIR}/nx-X11/programs/Xserver/nxagent
	dobin ${WORKDIR}/nx-X11/programs/nxauth/nxauth
	dobin ${WORKDIR}/nxproxy/nxproxy

	if use vnc ; then
		dobin ${WORKDIR}/nxviewer/nxviewer/nxviewer
		dobin ${WORKDIR}/nxviewer/nxpasswd/nxpasswd
	fi

	if use rdesktop ; then
		dobin ${WORKDIR}/nxdesktop/nxdesktop
	fi

	dolib.so ${WORKDIR}/nx-X11/lib/X11/libX11.so*
	dolib.so ${WORKDIR}/nx-X11/lib/Xext/libXext.so*
	dolib.so ${WORKDIR}/nx-X11/lib/Xrender/libXrender.so*
	dolib.so ${WORKDIR}/nxcomp/libXcomp.so*
	dolib.so ${WORKDIR}/nxcompext/libXcompext.so*
}
