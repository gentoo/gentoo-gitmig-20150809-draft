# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/eclean-kernel/eclean-kernel-0.2.1.ebuild,v 1.3 2012/02/09 23:27:58 mattst88 Exp $

EAPI=4
PYTHON_DEPEND='2:2.6'
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS='2.4 2.5 3.*'

inherit base distutils

DESCRIPTION="Remove outdated built kernels"
HOMEPAGE="https://github.com/mgorny/eclean-kernel/"
SRC_URI="mirror://github/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~mips ~x86 ~x86-fbsd"
IUSE=""

PYTHON_MODNAME=ecleankernel

src_prepare() {
	base_src_prepare
	distutils_src_prepare
}
