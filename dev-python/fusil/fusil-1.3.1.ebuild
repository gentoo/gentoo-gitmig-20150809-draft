# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fusil/fusil-1.3.1.ebuild,v 1.1 2009/11/15 17:50:32 arfrever Exp $

EAPI="2"
NEED_PYTHON="2.5"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Fusil the fuzzer is a Python library used to write fuzzing programs."
HOMEPAGE="http://bitbucket.org/haypo/fusil/wiki/Home http://pypi.python.org/pypi/fusil"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND=">=dev-python/python-ptrace-0.6"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="2.4"

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

src_prepare() {
	python_copy_sources --no-link

	conversion() {
		[[ "${PYTHON_ABI}" == 2.* ]] && return

		2to3-${PYTHON_ABI} -w . fuzzers/fusil-* fuzzers/notworking/fusil-* > /dev/null
		epatch python3.0.patch
	}
	python_execute_function --action-message 'Applying patches for Python ${PYTHON_ABI}' --failure-message 'Applying patches for Python ${PYTHON_ABI} failed' -s conversion
}

src_compile() {
	distutils_src_compile

	if use doc; then
		cd doc
		emake RST2HTML="rst2html.py" || die "Generation of documentation failed"
	fi
}

src_install(){
	distutils_src_install

	if use doc; then
		dohtml doc/*
	fi

	if use examples; then
		insinto "/usr/share/doc/${PF}"
		doins -r examples
	fi
}

pkg_postinst() {
	distutils_pkg_postinst

	enewgroup fusil
	enewuser fusil -1 -1 -1 "fusil"
}
