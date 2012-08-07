# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/install-mask/install-mask-0.0.2.ebuild,v 1.4 2012/08/07 20:27:26 aballier Exp $

EAPI=4
PYTHON_DEPEND='2:2.6 3:3.2'
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS='2.4 2.5 3.1'

inherit base distutils

DESCRIPTION="Handle INSTALL_MASK setting in make.conf"
HOMEPAGE="https://github.com/mgorny/install-mask/"
SRC_URI="mirror://github/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~mips ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="app-portage/flaggie
	dev-python/lxml"

PYTHON_MODNAME=installmask

src_prepare() {
	base_src_prepare
	distutils_src_prepare
}
