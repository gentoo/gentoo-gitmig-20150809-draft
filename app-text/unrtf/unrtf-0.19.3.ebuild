# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/unrtf/unrtf-0.19.3.ebuild,v 1.7 2004/09/24 21:06:14 batlogg Exp $

DESCRIPTION="Converts RTF files to various formats"
HOMEPAGE="http://www.gnu.org/software/unrtf/unrtf.html"
SRC_URI="http://www.gnu.org/software/unrtf/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ppc s390"
IUSE=""
DEPEND=""

src_compile() {
	make clean
	emake || die
}

src_install() {
	dobin unrtf
	doman unrtf.1
	dohtml doc/unrtf.html
	dodoc CHANGES COPYING README TODO
}
