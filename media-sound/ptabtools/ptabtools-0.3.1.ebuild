# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ptabtools/ptabtools-0.3.1.ebuild,v 1.2 2004/10/17 10:00:40 dholm Exp $

MY_PV=${PV%.*}-${PV##*.}

DESCRIPTION="A set of utilities to use powertab files (.ptb)"
HOMEPAGE="http://jelmer.vernstok.nl/oss/ptabtools/"
SRC_URI="http://jelmer.vernstok.nl/releases/${PN}_${MY_PV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="dev-libs/popt
	dev-libs/libxml2"

S=${WORKDIR}/${PN}-${PV%.*}

src_compile() {
	sed -i "s:CFLAGS =:CFLAGS = ${CFLAGS}:" Makefile
	emake || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1
	dodir /usr/lib/pkgconfig
	einstall || die
}
