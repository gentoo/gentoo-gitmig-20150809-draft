# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclCheck/tclCheck-1.1.13.ebuild,v 1.1 2009/09/09 23:57:42 mescalinum Exp $

EAPI=2

inherit toolchain-funcs

DESCRIPTION="Check for missing/extra/wrong brackets in a Tcl script"
HOMEPAGE="http://catless.ncl.ac.uk/Programs/tclCheck/"
SRC_URI="ftp://catless.ncl.ac.uk/pub/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/tcl"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e '/\$(CC)/s/\<-s\>//g' Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin tclCheck || die "install bin failed ($?)"
	doman tclCheck.1 || die "install man error"
	dodoc README || die "install doc error"
}
