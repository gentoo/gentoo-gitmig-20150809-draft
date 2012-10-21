# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/diffmask/diffmask-0.3.3-r2.ebuild,v 1.2 2012/10/21 08:10:41 mgorny Exp $

EAPI=4
PYTHON_COMPAT=(python2_6 python2_7 python3_1 python3_2)

inherit distutils-r1

DESCRIPTION="A utility to maintain package.unmask entries up-to-date with masks"
HOMEPAGE="https://bitbucket.org/mgorny/diffmask/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~mips ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=sys-apps/portage-2.1.8.3"
