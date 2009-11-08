# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/toolame/toolame-02l-r3.ebuild,v 1.2 2009/11/08 14:37:26 klausman Exp $

EAPI=2
inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="tooLAME - an optimized mpeg 1/2 layer 2 audio encoder"
HOMEPAGE="http://www.planckenergy.com"
SRC_URI="mirror://sourceforge/toolame/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.diff \
		"${FILESDIR}"/${P}-uint.patch \
		"${FILESDIR}"/${P}-uint32_t.patch
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
