# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vstrip/vstrip-0.8f.ebuild,v 1.1 2005/03/28 00:01:53 chriswhite Exp $

inherit eutils

DESCRIPTION="A program to split non-css dvd vobs into individual chapters"
HOMEPAGE="http://www.maven.de/code"
SRC_URI="http://files.digital-digest.com/downloads/files/encode/vStrip_${PV/./}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="app-text/dos2unix"
RDEPEND="virtual/libc"
S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/vstrip-0.8f-gentoo.patch
	dos2unix -q -o *.c *.h

	for file in *.c *.h ; do
		echo >>$file
	done
}

src_compile() {
	emake || die
}

src_install() {
	dobin vstrip
}
