# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ptabtools/ptabtools-0.3.1.ebuild,v 1.6 2006/10/29 22:35:33 flameeyes Exp $

IUSE=""

MY_PV=${PV%.*}-${PV##*.}

DESCRIPTION="A set of utilities to use powertab files (.ptb)"
HOMEPAGE="http://jelmer.vernstok.nl/oss/ptabtools/"
SRC_URI="http://jelmer.vernstok.nl/releases/${PN}_${MY_PV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~ppc sparc x86"

RDEPEND="dev-libs/popt
	dev-libs/libxml2
	=dev-libs/glib-2*"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

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
