# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xse/xse-2.1.ebuild,v 1.11 2008/10/14 01:39:40 darkside Exp $

inherit eutils

DESCRIPTION="Command Line Interface to XSendEvent()"
HOMEPAGE="ftp://ftp.x.org/R5contrib/"
SRC_URI="ftp://ftp.x.org/R5contrib/xsendevent-${PV}.tar.Z"
LICENSE="X11"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/libXt
	x11-misc/gccmakedep
	app-text/rman
	x11-libs/libXaw
	x11-libs/libXp"
DEPEND="${RDEPEND}
	x11-misc/imake"

src_compile() {
	xmkmf -a &> /dev/null || die
	econf; emake CCOPTIONS="${CFLAGS}" LOCAL_LDFLAGS=${LDFLAGS} || die
}

src_install() {
	dobin xse

	newman xse.man xse.1
	dodoc README

	dodir /usr/X11R6/lib/X11/app-defaults
	insinto /usr/X11R6/lib/X11/app-defaults
	newins Xse.ad Xse
}
