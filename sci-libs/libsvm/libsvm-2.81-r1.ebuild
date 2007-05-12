# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libsvm/libsvm-2.81-r1.ebuild,v 1.1 2007/05/12 00:44:00 ali_bush Exp $

inherit toolchain-funcs python java-pkg-opt-2

DESCRIPTION="Library for Support Vector Machines"
HOMEPAGE="http://www.csie.ntu.edu.tw/~cjlin/libsvm/"
SRC_URI="http://www.csie.ntu.edu.tw/~cjlin/libsvm/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="python java"

DEPEND="java? ( >=virtual/jdk-1.4 )"
#RDEPEND=""

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

	cd tools
	insinto /usr/share/doc/${PF}/tools
	doins easy.py grid.py subset.py
	docinto tools
	dodoc README
	cd -

	if use python ; then
		cd python
		python_version || die
		insinto /usr/lib/python${PYVER}/site-packages
		doins svmc.so svm.py || die
		docinto python
		dodoc README
		cd -
	fi

	if use java ; then
		cd java
		java-pkg_dojar libsvm.jar
		dohtml test_applet.html
		cd -
	fi
}
