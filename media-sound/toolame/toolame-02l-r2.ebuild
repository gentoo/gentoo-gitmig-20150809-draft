# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/toolame/toolame-02l-r2.ebuild,v 1.7 2009/08/03 13:12:37 ssuominen Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="tooLAME - an optimized mpeg 1/2 layer 2 audio encoder"
HOMEPAGE="http://www.planckenergy.com"
SRC_URI="mirror://sourceforge/toolame/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.diff"
	epatch "${FILESDIR}/${P}-uint.patch"
}

src_compile() {
	append-lfs-flags
	tc-export CC
	emake || die "emake failed"
}

src_install() {
	dobin toolame || die "dobin failed"
	dodoc README HISTORY FUTURE html/* text/*
}
