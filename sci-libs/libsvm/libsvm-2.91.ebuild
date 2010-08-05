# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libsvm/libsvm-2.91.ebuild,v 1.1 2010/08/05 20:25:14 bicatali Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit eutils java-pkg-opt-2 python

MY_P="${PN}-${PV%0}"

DESCRIPTION="Library for Support Vector Machines"
HOMEPAGE="http://www.csie.ntu.edu.tw/~cjlin/libsvm/"
SRC_URI="http://www.csie.ntu.edu.tw/~cjlin/libsvm/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="java python tools"

DEPEND="java? ( >=virtual/jdk-1.4 )"
RDEPEND="${DEPEND}
	tools? ( sci-visualization/gnuplot )"

S="${WORKDIR}"/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-makefile.patch
	sed -i -e "s@\.\./@${EPREFIX}/usr/bin/@g" tools/*.py \
		|| die "Failed to fix paths in python files"
	if use java; then
		local JAVAC_FLAGS="$(java-pkg_javac-args)"
		sed -i \
			-e "s/JAVAC_FLAGS =/JAVAC_FLAGS=${JAVAC_FLAGS}/g" \
			Makefile || die "Failed to fix java makefile"
	fi
}

src_compile() {
	emake || die "emake failed"
	if use java ; then
		emake -C java || die "emake for java modules failed"
	fi
}

src_install() {
	dobin svm-train svm-predict svm-scale \
		|| die "failed to install binaries"
	dolib.so *.so* || die "failed to install library"
	insinto /usr/include
	doins svm.h || die
	dohtml FAQ.html || die
	dodoc README

	if use tools; then
		for t in tools/*.py; do
			newbin ${t} svm-$(basename ${t} .py) || die "install tools failes"
		done
		newdoc tools/README README.tools
		insinto /usr/share/doc/${PF}
		doins heart_scale || die
		doins -r svm-toy || die
	fi

	if use python ; then
		installation() {
			insinto $(python_get_sitedir)
			doins python/*.py || die "python modules install failed"
		}
		python_execute_function installation
		newdoc python/README README.python
	fi

	if use java; then
		java-pkg_dojar java/libsvm.jar
		dohtml java/test_applet.html
	fi
}
