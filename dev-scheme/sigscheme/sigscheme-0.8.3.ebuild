# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/sigscheme/sigscheme-0.8.3.ebuild,v 1.1 2008/05/02 16:59:21 hkbst Exp $

DESCRIPTION="SigScheme is an R5RS Scheme interpreter for embedded use."
HOMEPAGE="http://code.google.com/p/sigscheme/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

src_compile() {
	econf --enable-hygienic-macro || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
