# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sancho/sancho-0.11-r1.ebuild,v 1.3 2006/02/20 04:21:54 kumba Exp $

inherit distutils eutils

MY_P=${P/s/S}
DESCRIPTION="Sancho is a unit testing framework"
HOMEPAGE="http://www.mems-exchange.org/software/sancho/"
SRC_URI="http://cheeseshop.python.org/packages/source/S/Sancho/${MY_P}.tar.gz"

LICENSE="CNRI"
SLOT="0.0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-rename-package.patch"
}

src_test() {
	mkdir "${T}/tests"
	"${python}" setup.py install --home="${T}/tests" "$@" || die
	pushd "${T}/tests"
	PYTHONPATH=lib/python "${python}" "${S}/test/test_unittest.py" \
		|| die "test failed"
	popd
	rm -rf "${T}/tests"
}

src_install() {
	mydoc="CHANGES.txt README.txt"
	distutils_src_install

	python_version
	insinto /usr/lib/python${PYVER}/site-packages/sancho-0
	dosym /usr/lib/python${PYVER}/site-packages/sancho0 \
		/usr/lib/python${PYVER}/site-packages/sancho-0/sancho
	echo sancho-0 > "${D}/usr/lib/python${PYVER}/site-packages/sancho-0.pth"
}

pkg_postinst() {
	einfo "This version of sancho is modified to allow parallel installation"
	einfo "with sancho-2.x. \"import sancho0\" will always give you this"
	einfo "version. \"import sancho\" will give you sancho 2.x if that is"
	einfo "installed, this version otherwise."
}
