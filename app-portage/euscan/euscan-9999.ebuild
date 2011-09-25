# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/euscan/euscan-9999.ebuild,v 1.1 2011/09/25 17:41:38 hwoarang Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45] 3.*"
PYTHON_USE_WITH="xml"
PYTHON_NONVERSIONED_EXECUTABLES=(".*")

inherit distutils python git-2

EGIT_REPO_URI="git://git.iksaif.net/euscan.git"

DESCRIPTION="Ebuild upstream scan utility"
HOMEPAGE="http://euscan.iksaif.net"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS=""

DEPEND="sys-apps/portage"
RDEPEND="${DEPEND}
	>=app-portage/gentoolkit-0.2.8
	dev-python/argparse
	dev-python/setuptools
	dev-python/beautifulsoup"

distutils_src_compile_pre_hook() {
	echo VERSION="9999-${EGIT_VERSION}" "$(PYTHON)" setup.py set_version
	VERSION="9999-${EGIT_VERSION}" "$(PYTHON)" setup.py set_version
}

src_compile() {
	distutils_src_compile
}
