# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dclock/dclock-2.1.2_p5.ebuild,v 1.1 2004/05/06 13:17:25 g2boojum Exp $

DESCRIPTION="Digital clock for the X window system."
SRC_URI="http://ftp.debian.org/debian/pool/main/d/${PN}/${PN}_${PV/_p*/}.orig.tar.gz
		http://ftp.debian.org/debian/pool/main/d/${PN}/${PN}_${PV/_p/-}.diff.gz"
HOMEPAGE="ftp://ftp.ac-grenoble.fr/ge/Xutils/"

S=${WORKDIR}/${PN}
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ../${PN}_${PV/_p/-}.diff || die "patch failed"
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
