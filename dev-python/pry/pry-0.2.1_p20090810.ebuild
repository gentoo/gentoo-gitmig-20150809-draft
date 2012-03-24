# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pry/pry-0.2.1_p20090810.ebuild,v 1.1 2012/03/24 23:36:00 radhermit Exp $

EAPI="4"

PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_MODNAME="libpry"

inherit distutils eutils

DESCRIPTION="A unit testing framework and coverage engine"
HOMEPAGE="https://github.com/cortesi/pry http://pypi.python.org/pypi/pry/"
SRC_URI="http://dev.gentoo.org/~radhermit/distfiles/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.2.1-exit-status.patch
}

src_test() {
	cd test

	testing() {
		PYTHONPATH="../build-${PYTHON_ABI}/lib" "$(PYTHON)" \
			../build-${PYTHON_ABI}/scripts-${PYTHON_ABI}/pry
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	use doc && dohtml -r doc/*
}
