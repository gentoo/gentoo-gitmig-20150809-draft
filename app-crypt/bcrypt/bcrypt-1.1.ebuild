# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/bcrypt/bcrypt-1.1.ebuild,v 1.10 2006/11/23 13:11:29 drizzt Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A file encryption utility using Paul Kocher's implementation of the blowfish algorithm"
HOMEPAGE="http://bcrypt.sourceforge.net/"
SRC_URI="mirror://sourceforge/bcrypt/${P}.tar.gz"
SLOT="0"
LICENSE="BSD"
KEYWORDS="alpha amd64 ppc ~ppc-macos sparc x86"
IUSE=""
DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-Makefile.patch
}

src_compile() {
	tc-export CC
	emake || die
}

src_install() {
	dobin bcrypt
	dodoc LICENSE README
	doman bcrypt.1
}
