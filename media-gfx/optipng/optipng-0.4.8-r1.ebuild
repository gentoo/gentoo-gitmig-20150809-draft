# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/optipng/optipng-0.4.8-r1.ebuild,v 1.5 2006/10/20 15:58:19 taviso Exp $

inherit eutils

DESCRIPTION="Find the optimal compression settings for your png files"
SRC_URI="http://www.cs.toronto.edu/~cosmin/pngtech/optipng/${P}.tar.gz"
HOMEPAGE="http://www.cs.toronto.edu/~cosmin/pngtech/optipng/"

LICENSE="as-is"

SLOT="0"
KEYWORDS="alpha ~amd64 ppc ~ppc-macos x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	sed -i -e 's!-O2!${CFLAGS}!' scripts/gcc.mak
	epatch ${FILESDIR}/optipng-zlib-security.diff
}

src_compile() {
	emake -C ${S}/src -f ${S}/src/scripts/gcc.mak optipng \
		CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dobin ${S}/src/optipng
	dodoc ${S}/doc/{CAVEAT,DESIGN,FEATURES,HISTORY,LICENSE,TODO,USAGE}
	dohtml ${S}/doc/index.html
}
