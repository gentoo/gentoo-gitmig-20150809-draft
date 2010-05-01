# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/toolame/toolame-02l-r3.ebuild,v 1.9 2010/05/01 15:44:41 aballier Exp $

EAPI=2
inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="tooLAME - an optimized mpeg 1/2 layer 2 audio encoder"
HOMEPAGE="http://www.planckenergy.com"
SRC_URI="mirror://sourceforge/toolame/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha ~amd64 hppa ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
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
