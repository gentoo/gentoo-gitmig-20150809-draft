# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/num-utils/num-utils-0.5.ebuild,v 1.3 2008/06/17 09:17:49 bicatali Exp $

IUSE=""

DESCRIPTION="A set of programs for dealing with numbers from the command line"
SRC_URI="http://suso.suso.org/programs/num-utils/downloads/${P}.tar.gz"
HOMEPAGE="http://suso.suso.org/programs/num-utils/"
LICENSE="GPL-2"
DEPEND=""
RDEPEND="dev-lang/perl"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"

src_compile() {
	sed -i \
		-e 's/^RPMDIR/#RPMDIR/' \
		-e 's/COPYING//' \
		-e '/^DOCS/s/MANIFEST//' \
		Makefile || die "sed Makefile failed"

	emake || die "emake failed"
}

src_install () {
	emake ROOT="${D}" install || die "emake install failed"
}
