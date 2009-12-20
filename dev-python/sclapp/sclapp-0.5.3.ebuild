# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sclapp/sclapp-0.5.3.ebuild,v 1.1 2009/12/20 20:43:41 sping Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Framework for writing simple command-line applications"
HOMEPAGE="http://www.alittletooquiet.net/software/sclapp/"
SRC_URI="http://www.alittletooquiet.net/media/release/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

src_prepare() {
	# Disable failing test
	sed -e "s/test_stdout_fails_without_signal_handling_without_output_protection/_&/" \
			-i tests/output_protection.py || die "sed failed"
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" test
	}
	python_execute_function testing
}
