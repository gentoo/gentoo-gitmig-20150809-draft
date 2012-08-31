# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/install-mask/install-mask-0.0.2-r1.ebuild,v 1.1 2012/08/31 09:09:32 mgorny Exp $

EAPI=4
PYTHON_COMPAT='python2_6 python2_7 python3_1 python3_2'

inherit base python-distutils-ng

DESCRIPTION="Handle INSTALL_MASK setting in make.conf"
HOMEPAGE="https://github.com/mgorny/install-mask/"
SRC_URI="mirror://github/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~mips ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="app-portage/flaggie
	dev-python/lxml"

python_prepare_all() {
	base_src_prepare
}
