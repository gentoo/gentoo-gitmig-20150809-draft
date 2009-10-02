# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sancho/sancho-0.11-r1.ebuild,v 1.22 2009/10/02 01:03:39 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

MY_P="${P/s/S}"

DESCRIPTION="Sancho is a unit testing framework"
HOMEPAGE="http://www.mems-exchange.org/software/sancho/"
SRC_URI="http://cheeseshop.python.org/packages/source/S/Sancho/${MY_P}.tar.gz"

LICENSE="CNRI"
SLOT="0.0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt"

src_prepare() {
	epatch "${FILESDIR}/${P}-rename-package.patch"
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" "${S}/test/test_unittest.py"
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	create_symlinks() {
		insinto $(python_get_sitedir)/sancho-0
		dosym $(python_get_sitedir)/sancho0 $(python_get_sitedir)/sancho-0/sancho
		echo sancho-0 > "${D}$(python_get_sitedir)/sancho-0.pth"
	}
	python_execute_function -q create_symlinks
}

pkg_postinst() {
	elog "This version of sancho is modified to allow parallel installation"
	elog "with sancho-2.x. \"import sancho0\" will always give you this"
	elog "version. \"import sancho\" will give you sancho 2.x if that is"
	elog "installed, this version otherwise."
}
