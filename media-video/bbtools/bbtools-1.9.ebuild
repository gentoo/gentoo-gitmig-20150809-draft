# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/bbtools/bbtools-1.9.ebuild,v 1.3 2005/09/16 02:29:25 mr_bones_ Exp $

inherit eutils

DESCRIPTION="bbdmux, bbinfo, bbvinfo and bbainfo from Brent Beyeler"
HOMEPAGE="http://members.cox.net/beyeler/bbmpeg.html"
SRC_URI="http://files.digital-digest.com/downloads/files/encode/bbtool${PV/./}_src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}

	mv BBINFO.cpp bbinfo.cpp || die
	mv BITS.CPP bits.cpp || die
	mv BITS.H bits.h || die
	mv bbdmux.CPP bbdmux.cpp || die
	rm *.ide
	edos2unix *.cpp *.h

	epatch "${FILESDIR}"/bbtools-${PV}-gentoo.patch
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin bbainfo bbdmux bbinfo bbvinfo || die "dobin failed"
}
