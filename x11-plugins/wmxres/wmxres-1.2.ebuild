# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmxres/wmxres-1.2.ebuild,v 1.1 2004/08/26 22:27:09 s4t4n Exp $

inherit eutils

IUSE=""

DESCRIPTION="Dock application to select your display mode among those possible"
SRC_URI="http://yalla.free.fr/wn/${PN}-1.1-0.tar.gz"
HOMEPAGE="http://yalla.free.fr/wn/"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-1"
KEYWORDS="~x86"

S="${WORKDIR}/${PN}.app"

src_unpack() {

	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-makefile.patch
	epatch ${FILESDIR}/${PN}-debian-1.1-1.2.patch

}

src_compile() {

	emake GCFLAGS="${CFLAGS}" || die "make failed"

}

src_install() {

	dobin ${PN}/${PN}
	doman ${PN}.1

	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop

}
