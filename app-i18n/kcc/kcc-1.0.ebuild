# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kcc/kcc-1.0.ebuild,v 1.13 2006/10/14 10:02:59 flameeyes Exp $

inherit toolchain-funcs eutils

DESCRIPTION="A Kanji code converter"
HOMEPAGE="none" # There doesn't seem to be a home page for this package!
SRC_URI="ftp://ftp.jp.freebsd.org/pub/FreeBSD/ports/distfiles/${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${PN}-gcc3-gentoo.diff"
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin kcc || die

	dodoc README
	insinto /usr/share/man/ja/man1
	newins kcc.jman kcc.1 || die
}
