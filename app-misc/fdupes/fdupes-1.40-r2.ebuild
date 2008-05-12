# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fdupes/fdupes-1.40-r2.ebuild,v 1.1 2008/05/12 22:02:27 pva Exp $

inherit eutils toolchain-funcs

DESCRIPTION="identify/delete duplicate files residing within specified directories"
HOMEPAGE="http://netdial.caribe.net/~adrian2/fdupes.html"
SRC_URI="http://netdial.caribe.net/~adrian2/programs/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="md5sum-external"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-memcpy.patch
	if use md5sum-external; then
		sed -i -e 's/^#EXTERNAL_MD5[[:blank:]]*= /EXTERNAL_MD5 = /g' \
					Makefile || die "sed failed"
	fi
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
