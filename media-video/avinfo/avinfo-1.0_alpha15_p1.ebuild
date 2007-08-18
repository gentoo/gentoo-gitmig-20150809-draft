# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avinfo/avinfo-1.0_alpha15_p1.ebuild,v 1.1 2007/08/18 17:55:17 drac Exp $

inherit eutils toolchain-funcs

MY_P=${PN}-1.0.a15unix

DESCRIPTION="Utility for displaying AVI information"
HOMEPAGE="http://shounen.ru/soft/avinfo/english.shtml"
SRC_URI="http://shounen.ru/soft/${PN}/${MY_P}.tar.gz
	http://shounen.ru/soft/${PN}/${MY_P}-patch1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""

S="${WORKDIR}"/${PN}-1.0.a15

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/${MY_P}-patch1/${MY_P}-patch1.diff
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed."
}

src_install() {
	dobin src/avinfo
	doman src/avinfo.1
	dodoc CHANGELOG README "${WORKDIR}"/${MY_P}-patch1/FIXES
	dodoc doc/*
}
