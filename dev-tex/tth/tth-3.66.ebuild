# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/tth/tth-3.66.ebuild,v 1.1 2005/02/12 14:23:11 usata Exp $

inherit toolchain-funcs

DESCRIPTION="TTH translates TEX into HTML."
HOMEPAGE="http://hutchinson.belmont.ma.us/tth/"
SRC_URI="http://hutchinson.belmont.ma.us/tth/tth-noncom/tth_C.tgz"

SLOT="0"
LICENSE="free-noncomm"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc"

S="${WORKDIR}/tth_C"

src_compile() {
	"$(tc-getCC)" -o tth tth.c || die "compile failed"
}

src_install() {
	dobin tth
	dodoc CHANGES
	doman tth.1
	dohtml *
}
