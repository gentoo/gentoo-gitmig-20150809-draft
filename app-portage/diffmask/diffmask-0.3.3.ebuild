# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/diffmask/diffmask-0.3.3.ebuild,v 1.3 2011/01/05 13:59:50 mgorny Exp $

EAPI=3
PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.4 2.5"

inherit distutils

DESCRIPTION="A utility to maintain package.unmask entries up-to-date with masks"
HOMEPAGE="https://github.com/mgorny/diffmask/"
SRC_URI="http://cloud.github.com/downloads/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=sys-apps/portage-2.1.8.3"
