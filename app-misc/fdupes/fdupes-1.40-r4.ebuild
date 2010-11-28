# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fdupes/fdupes-1.40-r4.ebuild,v 1.5 2010/11/28 12:14:00 hwoarang Exp $

inherit eutils toolchain-funcs

DESCRIPTION="identify/delete duplicate files residing within specified directories"
HOMEPAGE="http://netdial.caribe.net/~adrian2/fdupes.html"
SRC_URI="http://netdial.caribe.net/~adrian2/programs/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 s390 sparc x86"
IUSE="md5sum-external"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-memcpy.patch
	epatch "${FILESDIR}"/${P}-external-md5sum-quotation-1.patch
	if use md5sum-external; then
		sed -i -e 's/^#EXTERNAL_MD5[[:blank:]]*= /EXTERNAL_MD5 = /g' \
					Makefile || die "sed failed"
	fi
	sed -e 's/-o fdupes/${CFLAGS} ${LDFLAGS} -o fdupes/' -i Makefile
}

src_compile() {
	sed -i -e "s:gcc:$(tc-getCC):" Makefile
	emake || die
}

src_install() {
	dobin fdupes || die
	doman fdupes.1
	dodoc CHANGES CONTRIBUTORS INSTALL README TODO
}
