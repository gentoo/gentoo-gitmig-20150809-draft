# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/bbtools/bbtools-1.9.ebuild,v 1.5 2007/12/01 10:52:19 caster Exp $

inherit eutils flag-o-matic

DESCRIPTION="bbdmux, bbinfo, bbvinfo and bbainfo from Brent Beyeler"
HOMEPAGE="http://members.cox.net/beyeler/bbmpeg.html"
SRC_URI="http://files.digital-digest.com/downloads/files/encode/bbtool${PV/./}_src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
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
	append-lfs-flags
	emake || die "emake failed"
}

src_install() {
	dobin bbainfo bbdmux bbinfo bbvinfo || die "dobin failed"
}
