# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kcc/kcc-1.0.ebuild,v 1.17 2012/07/15 04:34:15 hattya Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="A Kanji code converter"
HOMEPAGE="http://www2s.biglobe.ne.jp/~Nori/ruby/"
SRC_URI="ftp://ftp.jp.freebsd.org/pub/FreeBSD/ports/distfiles/${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-gcc3-gentoo.diff"
	sed -i "s:\(-o kcc\):\$(LDFLAGS) \1:" Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin kcc
	dodoc README
	cp -f kcc.jman kcc.1 || die
	doman -i18n=ja kcc.1
}
