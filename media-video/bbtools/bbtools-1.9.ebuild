# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/bbtools/bbtools-1.9.ebuild,v 1.1 2005/03/27 23:14:13 chriswhite Exp $

inherit eutils

DESCRIPTION="bbdmux, bbinfo, bbvinfo and bbainfo from Brent Beyeler"
HOMEPAGE="http://members.cox.net/beyeler/bbmpeg.html"
SRC_URI="http://files.digital-digest.com/downloads/files/encode/bbtool${PV/./}_src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="virtual/libc"

S=${WORKDIR}

src_unpack() {
	unpack ${A}

	mv BBINFO.cpp bbinfo.cpp
	mv BITS.CPP bits.cpp
	mv BITS.H bits.h
	mv bbdmux.CPP bbdmux.cpp
	rm *.ide
	edos2unix *.cpp *.h

	epatch ${FILESDIR}/bbtools-${PV}-gentoo.patch
}

src_compile() {
	make || die "make failed"
}

src_install() {
	dobin bbainfo bbdmux bbinfo bbvinfo
}
