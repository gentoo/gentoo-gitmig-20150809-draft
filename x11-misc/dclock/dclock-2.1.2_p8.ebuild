# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dclock/dclock-2.1.2_p8.ebuild,v 1.1 2006/07/12 02:50:42 g2boojum Exp $

inherit eutils

DESCRIPTION="Digital clock for the X window system."
SRC_URI="mirror://debian/pool/main/d/${PN}/${PN}_${PV/_p*/}.orig.tar.gz
		mirror://debian/pool/main/d/${PN}/${PN}_${PV/_p/-}.diff.gz"
HOMEPAGE="ftp://ftp.ac-grenoble.fr/ge/Xutils/"

S=${WORKDIR}/${PN}
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXt
		x11-libs/libXext )
	virtual/x11 )
	app-text/rman"
DEPEND="${RDEPEND}
	|| ( (
		x11-misc/imake
		x11-proto/xproto )
	virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ../${PN}_${PV/_p/-}.diff
	ln -sf dclock.1 dclock.man # needed to fix xmkmf breakage
}

src_compile() {
	xmkmf || die "xmkmf failed"
	make CFLAGS="${CFLAGS}" || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	make DESTDIR=${D} install.man || die "make install.man failed"
	insinto /usr/share/sounds
	doins sounds/*
	insinto /etc/X11/app-defaults
	newins Dclock.ad DClock
	dodoc README TODO
}
