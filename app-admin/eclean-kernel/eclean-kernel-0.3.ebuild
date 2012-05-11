# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eclean-kernel/eclean-kernel-0.3.ebuild,v 1.1 2012/05/11 17:35:25 mgorny Exp $

EAPI=4

PYTHON_COMPAT='python2_6 python2_7'
inherit base python-distutils-ng

DESCRIPTION="Remove outdated built kernels"
HOMEPAGE="https://bitbucket.org/mgorny/eclean-kernel/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~mips ~x86 ~x86-fbsd"
IUSE=""

PDEPEND="kernel_linux? ( dev-python/pymountboot )"

python_prepare_all() {
	base_src_prepare
}

python_install_all() {
	dodoc README
}
