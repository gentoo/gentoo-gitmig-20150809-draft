# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/namebench/namebench-1.2.ebuild,v 1.4 2011/03/12 13:23:02 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
PYTHON_USE_WITH_OPT="X"
PYTHON_USE_WITH="tk"

inherit distutils

DESCRIPTION="DNS Benchmark Utility"
HOMEPAGE="http://code.google.com/p/namebench/"
SRC_URI="http://namebench.googlecode.com/files/${P}-source.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-python/dnspython-1.8.0
	dev-python/graphy
	dev-python/httplib2
	dev-python/jinja"

pkg_setup() {
	python_pkg_setup
	python_set_active_version 2
}

src_prepare() {
	python_convert_shebangs -r 2 .

	# don't include bundled libraries
	export NO_THIRD_PARTY=1
}

src_install() {
	distutils_src_install --install-data=/usr/share

	dosym ${PN}.py /usr/bin/${PN} || die
}
