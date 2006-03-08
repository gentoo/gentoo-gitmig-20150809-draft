# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/esr-hexdump/esr-hexdump-1.6.ebuild,v 1.2 2006/03/08 17:29:48 twp Exp $

inherit toolchain-funcs

MY_P=${P/esr-/}
DESCRIPTION="Eric Raymond's hex dumper"
HOMEPAGE="http://www.catb.org/~esr/hexdump/"
SRC_URI="http://www.catb.org/~esr/hexdump/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ~ppc-macos ppc64 x86"
IUSE=""
S=${WORKDIR}/${MY_P}

src_compile() {
	emake CC="$(tc-getCC) $CFLAGS" || die
	mv hexdump esr-hexdump
	mv hexdump.1 esr-hexdump.1
}

src_install() {
	dobin esr-hexdump || die
	doman esr-hexdump.1
	dodoc README
	dosym esr-hexdump /usr/bin/hex
}
