# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/diffmask/diffmask-0.3.1.ebuild,v 1.1 2010/10/23 19:22:18 mgorny Exp $

EAPI=1
PYTHON_DEPEND="2:2.6"

inherit python

DESCRIPTION="An utility to maintain package.unmask entries up-to-date with masks"
HOMEPAGE="http://github.com/mgorny/diffmask/"
SRC_URI="http://github.com/downloads/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="sys-apps/portage"

src_install() {
	dobin ${PN} || die
	dodoc README || die
}
