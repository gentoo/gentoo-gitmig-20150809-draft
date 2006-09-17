# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibclean/bibclean-2.11.4.ebuild,v 1.2 2006/09/17 16:14:47 jhuebel Exp $

inherit toolchain-funcs

DESCRIPTION="BibTeX bibliography prettyprinter and syntax checker"
SRC_URI="http://www.math.utah.edu/pub/bibclean/${P}.tar.bz2"
HOMEPAGE="http://www.math.utah.edu/pub/bibclean/"

# http://packages.debian.org/changelogs/pool/main/b/bibclean/bibclean_2.11.4-5/bibclean.copyright
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

SLOT="0"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="$CFLAGS" || die "emake failed"
}

src_test() {
	make test || die
}

src_install() {
	dobin bibclean
	newman bibclean.man bibclean.1
}
