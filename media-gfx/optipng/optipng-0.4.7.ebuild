# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/optipng/optipng-0.4.7.ebuild,v 1.1 2005/01/13 23:49:08 taviso Exp $

inherit eutils flag-o-matic

DESCRIPTION="Find the optimal compression settings for your png files"
SRC_URI="http://www.cs.toronto.edu/~cosmin/pngtech/optipng/${P}.tar.gz"
HOMEPAGE="http://www.cs.toronto.edu/~cosmin/pngtech/optipng/"

LICENSE="as-is"

SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	cd ${S}/src
	sed -i -e 's!-O2!${CFLAGS}!' scripts/gcc.mak
	emake -f scripts/gcc.mak optipng CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" || die

	# some feedback everything went ok...
	echo; ls -l optipng; size optipng
}

src_install() {
	dobin ${S}/src/optipng
	dodoc ${S}/doc/{CAVEAT,DESIGN,FEATURES,HISTORY,LICENSE,README,TODO,USAGE}
	dohtml ${S}/doc/index.html
}
