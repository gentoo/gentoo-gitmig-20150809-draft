# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/g3data/g3data-1.5.0.ebuild,v 1.1 2006/06/06 10:22:27 cryos Exp $

DESCRIPTION="Tool for extracting data from graphs"
HOMEPAGE="http://koti.welho.com/jfrantz/software/g3data.html"
SRC_URI="http://koti.welho.com/jfrantz/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND=">=x11-libs/gtk+-2.6.0
	media-libs/imlib"
DEPEND="${RDEPEND}
	~app-text/docbook-sgml-utils-0.6.14"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin g3data || die "dobin failed - no binary!"
	doman g3data.1.gz || die "doman failed"
	dodoc README.SOURCE || die "README.SOURCE not found"
	if use examples; then
		dodoc README.TEST
		insinto ${DESTDIR}usr/share/doc/${PF}/
		doins test1.png test1.values test2.png test2.values
	fi
}
