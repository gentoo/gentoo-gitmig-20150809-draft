# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gts/gts-20111025.ebuild,v 1.1 2012/01/20 19:17:11 bicatali Exp $

EAPI=4
AUTOTOOLS_AUTORECONF=yes
inherit fortran-2 autotools-utils

DESCRIPTION="GNU Triangulated Surface Library"
LICENSE="LGPL-2"
HOMEPAGE="http://gts.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~bicatali/distfiles/${P}.tar.gz"
# wget http://gts.sf.net/gts-snapshot.tar.gz and upload

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc examples static-libs test"

RDEPEND="virtual/fortran
	dev-libs/glib:2
	!<=sci-chemistry/ccp4-apps-6.1.3-r2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? ( media-libs/netpbm )"

# buggy
RESTRICT=test

PATCHES=( "${FILESDIR}"/${P}-autotools.patch )
S="${WORKDIR}"/${P/-20/-snapshot-}

src_test() {
	chmod +x test/*/*.sh
	cd ${AUTOTOOLS_BUILD_DIR}/test/boolean
	ln -s "${S}"/test/boolean/{tests,surfaces} .
	autotools-utils_src_test
}

src_install() {
	autotools-utils_src_install

	# rename to avoid collisions
	mv "${ED}"/usr/bin/{,gts-}split || die
	mv "${ED}"/usr/bin/{,gts-}merge || die

	use doc && dohtml doc/html/*

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.c
	fi
}
