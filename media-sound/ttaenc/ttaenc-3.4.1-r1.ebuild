# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ttaenc/ttaenc-3.4.1-r1.ebuild,v 1.1 2010/10/19 20:34:01 chainsaw Exp $

EAPI=2

inherit toolchain-funcs

DESCRIPTION="True Audio Compressor Software"
HOMEPAGE="http://tta.sourceforge.net"
SRC_URI="mirror://sourceforge/tta/${P}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="sys-apps/sed"

S=${WORKDIR}/${P}-src

src_prepare() {
	sed -i -e "s:gcc:$(tc-getCC):g" Makefile \
		|| die "Unable to set compiler"
	sed -i -e "s:-o:${LDFLAGS} -o:g" Makefile \
		|| die "Unable to set LDFLAGS"
}

src_compile () {
	emake CFLAGS="${CFLAGS}" || die "emake failed."
}

src_install () {
	dobin ttaenc
	dodoc ChangeLog-${PV} README
}
