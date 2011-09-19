# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/install-mask/install-mask-0.0.1.ebuild,v 1.1 2011/09/19 08:26:53 mgorny Exp $

EAPI=3
PYTHON_DEPEND='*:2.6'
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS='2.4 2.5'

inherit base distutils

DESCRIPTION="Handle INSTALL_MASK setting in make.conf"
HOMEPAGE="https://github.com/mgorny/install-mask/"
SRC_URI="http://cloud.github.com/downloads/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-portage/flaggie
	dev-python/lxml"

PYTHON_MODNAME=installmask

src_prepare() {
	base_src_prepare
	distutils_src_prepare
}
