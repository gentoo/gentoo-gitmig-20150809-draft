# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/num-utils/num-utils-0.5.ebuild,v 1.6 2010/06/24 13:00:56 jlec Exp $

IUSE=""

DESCRIPTION="A set of programs for dealing with numbers from the command line"
SRC_URI="http://suso.suso.org/programs/num-utils/downloads/${P}.tar.gz"
HOMEPAGE="http://suso.suso.org/programs/num-utils/"
LICENSE="GPL-2"
DEPEND=""
RDEPEND="dev-lang/perl"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"

RDEPEND="!<sci-chemistry/gromacs-4"

src_compile() {
	# bug #248324
	mv normalize nnormalize || die
	sed -i \
		-e 's/^RPMDIR/#RPMDIR/' \
		-e 's/COPYING//' \
		-e '/^DOCS/s/MANIFEST//' \
		-e 's/normalize/nnormalize/' \
		Makefile || die "sed Makefile failed"
	emake || die "emake failed"
}

src_install () {
	emake ROOT="${D}" install || die "emake install failed"
}

pkg_postinst() {
	elog "normalize has been renamed nnormalize"
}
