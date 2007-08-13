# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/toolame/toolame-02l-r2.ebuild,v 1.6 2007/08/13 21:18:24 dertobi123 Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="tooLAME - an optimized mpeg 1/2 layer 2 audio encoder"
HOMEPAGE="http://www.planckenergy.com"
SRC_URI="mirror://sourceforge/toolame/${P}.tgz"

IUSE=""

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="amd64 ppc ~sparc x86"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-gentoo.diff"
	epatch "${FILESDIR}/${P}-uint.patch"
}

src_compile() {
	# Enable largefile support, as toolame doesn't use autoconf
	append-lfs-flags

	tc-export CC

	emake || die
}

src_install() {
	dobin toolame || die
	dodoc README HISTORY FUTURE html/* text/*
}
