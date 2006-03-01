# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cuegen/cuegen-1.2.0.ebuild,v 1.2 2006/03/01 06:06:41 mr_bones_ Exp $

inherit eutils toolchain-funcs

DESCRIPTION="CUEgen is a FLAC-compatible cuesheet generator for Linux"
HOMEPAGE="http://www.cs.man.ac.uk/~slavinp/cuegen.html"
SRC_URI="http://www.cs.man.ac.uk/~slavinp/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin cuegen || die "install failed"
	dodoc README
}
