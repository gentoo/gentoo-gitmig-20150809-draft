# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/barcode/barcode-0.98.ebuild,v 1.20 2012/06/02 08:03:24 zmedico Exp $

EAPI="3"

inherit eutils multilib toolchain-funcs

DESCRIPTION="barcode generator"
HOMEPAGE="http://www.gnu.org/software/barcode/"
SRC_URI="mirror://gnu/barcode/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${PV}-info.patch
	sed -i \
		-e 's:/info:/share/info:' \
		-e 's:/man/:/share/man/:' \
		Makefile.in || die "sed failed"
}

src_configure() {
	tc-export CC
	econf
}

src_install() {
	emake install prefix="${ED}/usr" LIBDIR="\$(prefix)/$(get_libdir)" || die
	dodoc ChangeLog README TODO doc/barcode.{pdf,ps}
}
