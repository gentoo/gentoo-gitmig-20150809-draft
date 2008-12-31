# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cgal-python/cgal-python-0.9.3.ebuild,v 1.2 2008/12/31 06:29:35 mr_bones_ Exp $

EAPI=2
inherit toolchain-funcs python

INRIAID=3521

DESCRIPTION="Python bindings for the CGAL library"
HOMEPAGE="http://cgal-python.gforge.inria.fr/"
SRC_URI="http://gforge.inria.fr/frs/download.php/${INRIAID}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND="sci-mathematics/cgal"

S="${WORKDIR}/${PN}"

src_prepare() {
	python_version
	sed -i \
		-e "s:-I../.. -O2:-I/usr/include/python${PYVER} -I../..:g" \
		bindings/makefile.inc || die
	for i in $(find bindings -name Makefile); do
		sed -i -e "s:@g++:@$(tc-getCXX):g" ${i}  || die
	done
}

src_test() {
	emake -j1 tests || die "emake tests failed"
}

src_install(){
	python_need_rebuild
	emake package || die "emake package failed"
	insinto "$(${python} -c 'from distutils.sysconfig import get_python_lib;print get_python_lib()')"
	doins -r cgal_package/CGAL || die "python lib install failed"
	dodoc README.txt CHANGES
	if use examples; then
		cd tests
		make clean
		insinto /usr/share/doc/${PF}/examples
		cp -r * || die
	fi
}
