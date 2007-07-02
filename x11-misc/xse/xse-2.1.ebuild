# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xse/xse-2.1.ebuild,v 1.6 2007/07/02 12:47:05 angelos Exp $

inherit eutils

DESCRIPTION="Command Line Interface to XSendEvent()"
HOMEPAGE="ftp://ftp.x.org/R5contrib/"
SRC_URI="ftp://ftp.x.org/R5contrib/xsendevent-${PV}.tar.Z"
LICENSE="X11"
SLOT="0"
KEYWORDS="amd64 ppc ~x86"
IUSE=""
DEPEND="|| ( (
			x11-misc/imake
			x11-libs/libXt
			x11-misc/gccmakedep
			app-text/rman
		) virtual/x11
	)"

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
