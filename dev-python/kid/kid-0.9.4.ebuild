# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kid/kid-0.9.4.ebuild,v 1.2 2006/12/24 09:28:20 lucass Exp $

inherit distutils eutils

DESCRIPTION="A simple and Pythonic XML template language"
SRC_URI="http://www.kid-templating.org/dist/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.kid-templating.org/"

KEYWORDS="~amd64 ~ia64 ~x86"
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	|| ( >=dev-lang/python-2.5 dev-python/elementtree )"


src_unpack() {
	unpack ${A}
	cd ${S}

	# use distutils instead of egg
	epatch ${FILESDIR}/kid-0.9.4-ezsetup-gentoo.patch
}

src_test() {
	${python} run_tests.py -x || die "run_tests.py failed"
}

src_install() {
	distutils_src_install

	dobin bin/*

	dodoc doc/*.txt COPYING HISTORY RELEASING
	dohtml -r doc/html/*

	insinto /usr/share/doc/${PF}
	doins -r examples
}

pkg_postinst() {
	einfo "Installing dev-python/celementtree may enhance performance."
}

