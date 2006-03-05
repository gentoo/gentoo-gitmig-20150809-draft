# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nx-x11/nx-x11-1.5.0-r5.ebuild,v 1.1 2006/03/05 13:21:33 stuart Exp $

inherit eutils

DESCRIPTION="A special version of the X11 libraries supporting NX compression technology"
HOMEPAGE="http://www.nomachine.com/developers.php"
URI_BASE="http://64.34.161.181/download/1.5.0/sources/"
SRC_NX_X11="nx-X11-$PV-21.tar.gz"
SRC_NXAGENT="nxagent-$PV-112.tar.gz"
SRC_NXAUTH="nxauth-$PV-1.tar.gz"
SRC_NXCOMP="nxcomp-$PV-80.tar.gz"
SRC_NXCOMPEXT="nxcompext-$PV-20.tar.gz"
SRC_NXVIEWER="nxviewer-$PV-15.tar.gz"
SRC_NXDESKTOP="nxdesktop-$PV-78.tar.gz"
SRC_NXESD="nxesd-$PV-3.tar.gz"
SRC_URI="$URI_BASE/$SRC_NX_X11 $URI_BASE/$SRC_NXAGENT $URI_BASE/$SRC_NXAUTH $URI_BASE/$SRC_NXCOMP $URI_BASE/$SRC_NXCOMPEXT $URI_BASE/$SRC_NXVIEWER $URI_BASE/$SRC_NXDESKTOP $URI_BASE/$SRC_NXESD"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
#RESTRICT="nostrip"
DEPEND="virtual/x11
	media-libs/jpeg"
#RDEPEND=""
S=${WORKDIR}/${PN//x11/X11}

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
	epatch ${FILESDIR}/1.5.0/nx-x11-windows-linux-resume.patch
	cd ../nxcomp
	epatch ${FILESDIR}/1.5.0/nxcomp-gcc4.patch
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
	dolib libXcomp.so.1.5.0
	dolib libXcomp.so
	popd

	pushd ../nxcompext/
	dolib libXcompext.so.1.5.0
	dolib libXcompext.so
	popd

	preplib /usr/NX

	insinto /usr/X11R6/include
	doins ../nxcomp/NX.h

	insinto /etc/env.d
	doins ${FILESDIR}/1.5.0/50nx-x11

	dodir /var/lib/nxserver

	return

	cd ../nxesd
	emake DESTDIR=${D} install || die "unable to install nxesd"
}
