# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sclapp/sclapp-0.5.3.ebuild,v 1.3 2010/02/07 21:00:29 pva Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit eutils distutils

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
	epatch "${FILESDIR}/${P}-testsuite-fix-from-r235.patch"
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" test
	}
	python_execute_function testing
}
