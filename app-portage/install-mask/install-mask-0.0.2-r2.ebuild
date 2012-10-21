# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/install-mask/install-mask-0.0.2-r2.ebuild,v 1.2 2012/10/21 08:13:56 mgorny Exp $

EAPI=4
PYTHON_COMPAT=(python2_6 python2_7 python3_1 python3_2)

inherit distutils-r1

DESCRIPTION="Handle INSTALL_MASK setting in make.conf"
HOMEPAGE="https://bitbucket.org/mgorny/install-mask/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~mips ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="app-portage/flaggie[${PYTHON_USEDEP}]
	dev-python/lxml"
