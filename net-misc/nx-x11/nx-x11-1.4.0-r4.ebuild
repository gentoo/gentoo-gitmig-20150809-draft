# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nx-x11/nx-x11-1.4.0-r4.ebuild,v 1.1 2005/02/19 10:11:54 stuart Exp $

inherit eutils

MY_PN="${PN//x11/X11}"
MY_PV="${PV}-10"
DESCRIPTION="A special version of the X11 libraries supporting NX compression technology"
HOMEPAGE="http://www.nomachine.com/developers.php"
URI_BASE="http://www.nomachine.com/download/nxsources/"
URI_BASE2="http://www.nomachine.com/download/nxsources/"
SRC_NX_X11="${MY_PN}-${MY_PV}.tar.gz"
SRC_NXAGENT="nxagent-1.4.0-65.tar.gz"
SRC_NXAUTH="nxauth-1.4.0-2.tar.gz"
SRC_NXCOMP="nxcomp-1.4.0-31.tar.gz"
SRC_NXCOMPEXT="nxcompext-1.4.0-3.tar.gz"
SRC_NXVIEWER="nxviewer-1.4.0-4.tar.gz"
SRC_NXDESKTOP="nxdesktop-1.4.0-61.tar.gz"
SRC_NXESD="nxesd-1.4.0-1.tar.gz"
SRC_URI="$URI_BASE/nx-X11/${SRC_NX_X11} $URI_BASE/nxagent/${SRC_NXAGENT} $URI_BASE/nxauth/${SRC_NXAUTH} $URI_BASE/nxcomp/${SRC_NXCOMP} $URI_BASE/nxcompext/${SRC_NXCOMPEXT} $URI_BASE/nxviewer/${SRC_NXVIEWER} $URI_BASE/nxdesktop/${SRC_NXDESKTOP} $URI_BASE/nxesd/${SRC_NXESD}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
#RESTRICT="nostrip"
DEPEND="virtual/x11
	media-libs/jpeg"
#RDEPEND=""
S=${WORKDIR}/${MY_PN}

src_unpack() {
	# we can't use ${A} because of bug #61977
	unpack ${SRC_NX_X11}
	unpack ${SRC_NXAGENT}
	unpack ${SRC_NXAUTH}
	unpack ${SRC_NXCOMP}
	unpack ${SRC_NXCOMPEXT}
	unpack ${SRC_NXVIEWER}
	unpack ${SRC_NXDESKTOP}
	unpack ${SRC_NXESD}

	cd ${S}
	epatch ${FILESDIR}/${PN}-${PV}.xprint.patch
}

src_compile() {
	emake World || die "unable to build nx-11"

	cd ../nxviewer
	xmkmf || die "unable to create makefile for nxviewer"
	emake World || die "unable to make nxviewer"

	cd ../nxdesktop
	./configure --prefix=/usr/NX --mandir=/usr/share/man --sharedir=/usr/share || die "Unable to configure nxdesktop"
	emake || die "Unable to build nxdesktop"

	return

	# mxesd support will have to wait for a later release

	cd ../nxesd
	econf --prefix=/usr/NX || die "Unable to configure nxesd"
	emake || die "Unable to build nxesd"
}

src_install() {
	into /usr/NX

	dobin programs/Xserver/nxagent
	dobin programs/nxauth/nxauth
	dobin ../nxviewer/nxviewer/nxviewer
	dobin ../nxviewer/nxpasswd/nxpasswd
	dobin ../nxdesktop/nxdesktop

	pushd lib/X11/
	dolib libX11.so.6.2
	dolib libX11.so
	popd

	pushd lib/Xext/
	dolib libXext.so.6.4
	dolib libXext.so
	popd

	pushd lib/Xrender/
	dolib libXrender.so.1.2
	dolib libXrender.so
	popd

	pushd ../nxcomp/
	dolib libXcomp.so.1.4.0
	dolib libXcomp.so
	popd

	pushd ../nxcompext/
	dolib libXcompext.so.1.4.0
	dolib libXcompext.so
	popd

	preplib /usr/NX

	insinto /usr/X11R6/include
	doins ../nxcomp/NX.h

	dodir /var/lib/nxserver

	return

	# nxesd support will have to wait for a later release

	cd ../nxesd
	emake DESTDIR=${D} install || die "unable to install nxesd"
}
