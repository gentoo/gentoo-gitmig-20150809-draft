# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kcc/kcc-1.0.ebuild,v 1.6 2004/01/07 09:46:07 usata Exp $

inherit gcc

IUSE=""

KEYWORDS="x86"
S="${WORKDIR}/${PN}"
DESCRIPTION="A Kanji code converter"
SRC_URI="ftp://ftp.jp.freebsd.org/pub/FreeBSD/ports/distfiles/${PN}.tar.gz"
HOMEPAGE="" 	#There doesn't seem to be a home page for this package!
LICENSE="GPL-2"

DEPEND="virtual/glibc"

SLOT="0"

src_unpack() {

	# unpack the archive
	unpack ${A}

	cd ${S}
	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "3" ]
	then
		epatch ${FILESDIR}/${PN}-gcc3-gentoo.diff
	fi
}

src_compile() {

	emake || die
}

src_install () {

	dobin kcc || die

	dodoc README
	insinto /usr/share/man/ja/man1
	newins kcc.jman kcc.1 || die
}
