# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kcc/kcc-1.0.ebuild,v 1.12 2005/05/16 04:06:12 usata Exp $

inherit toolchain-funcs eutils

DESCRIPTION="A Kanji code converter"
HOMEPAGE="" # There doesn't seem to be a home page for this package!
SRC_URI="ftp://ftp.jp.freebsd.org/pub/FreeBSD/ports/distfiles/${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}

	cd ${S}
	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "3" ]
	then
		epatch ${FILESDIR}/${PN}-gcc3-gentoo.diff
	fi
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
