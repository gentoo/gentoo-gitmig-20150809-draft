# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/flaggie/flaggie-0.0.2.ebuild,v 1.1 2010/11/10 17:23:46 mgorny Exp $

EAPI=2
PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.4 2.5"

inherit base distutils

DESCRIPTION="A smart CLI mangler for package.* files"
HOMEPAGE="https://github.com/mgorny/flaggie/"
SRC_URI="https://github.com/downloads/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-apps/portage"

src_prepare() {
	base_src_prepare
	distutils_src_prepare
}
