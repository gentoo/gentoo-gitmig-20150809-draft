# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nx-x11/nx-x11-1.4.0.ebuild,v 1.2 2004/08/30 20:59:42 stuart Exp $

MY_PN="${PN//x11/X11}"
MY_PV="${PV}-3"
DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://www.nomachine.com/developers/"
URI_BASE="http://www.nomachine.com/download/snapshot/nxsources/"
URI_BASE2="http://www.nomachine.com/download/nxsources/"
SRC_NX_X11="${MY_PN}-${MY_PV}.tar.gz"
SRC_NXAGENT="nxagent-1.4.0-44.tar.gz"
SRC_NXAUTH="nxauth-1.4.0-1.tar.gz"
SRC_NXCOMP="nxcomp-1.3.2-4.tar.gz"
SRC_NXCOMPEXT="nxcompext-1.4.0-3.tar.gz"
SRC_NXVIEWER="nxviewer-1.4.0-2.tar.gz"
SRC_NXDESKTOP="nxdesktop-1.4.0-36.tar.gz"
SRC_NXESD="nxesd-1.4.0-1.tar.gz"
SRC_URI="$URI_BASE/${SRC_NX_X11} $URI_BASE/${SRC_NXAGENT} $URI_BASE/${SRC_NXAUTH} $URI_BASE2/${SRC_NXCOMP} $URI_BASE/${SRC_NXCOMPEXT} $URI_BASE/${SRC_NXVIEWER} $URI_BASE/${SRC_NXDESKTOP} $URI_BASE/${SRC_NXESD}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
#RESTRICT="nostrip"
DEPEND="virtual/x11"
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

	dolib ../nxcomp/libXcomp.so
	dolib ../nxcompext/libXcompext.so
	dolib lib/X11/libX11.so
	dolib lib/Xext/libXext.so
	dolib lib/Xrender/libXrender.so

	preplib /usr/NX

	dodir /var/lib/nxserver

	return

	# nxesd support will have to wait for a later release

	cd ../nxesd
	emake DESTDIR=${D} install || die "unable to install nxesd"
}
