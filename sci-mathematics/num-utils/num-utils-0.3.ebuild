# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/num-utils/num-utils-0.3.ebuild,v 1.1 2004/12/28 14:45:31 ribosome Exp $

IUSE=""

DESCRIPTION="A set of programs for dealing with numbers from the command line"
SRC_URI="http://suso.suso.org/programs/num-utils/downloads/${P}.tar.gz"
HOMEPAGE="http://suso.suso.org/programs/num-utils/"
LICENSE="GPL-2"
DEPEND=""
RDEPEND="dev-lang/perl"

SLOT="0"
KEYWORDS="~x86"

src_compile() {
	emake || die
}

src_install () {
	make ROOT=${D} install || die
	dodoc CHANGELOG COPYING GOALS LICENSE MANIFEST README VERSION WARNING
}
