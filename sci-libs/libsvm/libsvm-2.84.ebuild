# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libsvm/libsvm-2.84.ebuild,v 1.6 2008/05/04 17:35:11 nixnut Exp $

inherit java-pkg-opt-2 python toolchain-funcs multilib

DESCRIPTION="Library for Support Vector Machines"
HOMEPAGE="http://www.csie.ntu.edu.tw/~cjlin/libsvm/"
SRC_URI="http://www.csie.ntu.edu.tw/~cjlin/libsvm/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="java python tools"

DEPEND="java? ( >=virtual/jdk-1.4 )"
RDEPEND="${DEPEND}
	tools? ( sci-visualization/gnuplot )"

src_compile() {
	emake CXXC="$(tc-getCXX)" CFLAGS="${CXXFLAGS}" || die

	sed -i -e 's@\.\./@/usr/bin/@g' tools/*.py || die

	if use python ; then
		cd python
		python_version || die
		emake CC="$(tc-getCXX)" \
			CFLAGS="${CXXFLAGS} -I/usr/include/python${PYVER} -I.." all || die
		cd -
	fi

	if use java ; then
		cd java
		local JAVAC_FLAGS="$(java-pkg_javac-args)"
		sed -i -e "s/JAVAC_FLAGS =/JAVAC_FLAGS=${JAVAC_FLAGS}/g" Makefile || die
		emake || die
		cd -
	fi
}

src_install() {
	dobin svm-train svm-predict svm-scale || die
	dohtml FAQ.html
	dodoc README

	if use tools; then
		cd tools
		insinto /usr/share/doc/${PF}/tools
		doins easy.py grid.py subset.py
		docinto tools
		dodoc README
		cd -
	fi

	if use python ; then
		cd python
		python_version || die
		insinto /usr/$(get_libdir)/python${PYVER}/site-packages
		doins svmc.so svm.py || die
		docinto python
		dodoc README
		cd -
	fi

	if use java ; then
		cd java
		java-pkg_dojar libsvm.jar
		docinto html
		dohtml test_applet.html
		cd -
	fi
}
