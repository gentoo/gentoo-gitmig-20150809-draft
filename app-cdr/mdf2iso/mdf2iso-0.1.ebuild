# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/mdf2iso/mdf2iso-0.1.ebuild,v 1.1 2004/12/03 04:46:27 pylon Exp $

DESCRIPTION="A very simple utility to convert an Alcohol 120% bin image to the standard ISO-9660 format."
HOMEPAGE="http://mdf2iso.berlios.de/"
SRC_URI="http://download.berlios.de/mdf2iso/mdf2iso.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

S=${WORKDIR}/${PN}

src_compile() {
	# Fix makefile
	sed -i "s#all: mdf2iso.c#all: src/mdf2iso.c#" Makefile
	emake
}

src_install() {
	cd "${WORKDIR}/${PN}"
	dodoc CHANGELOG
	dobin mdf2iso
}
