# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/genetic/genetic-0.1.1.ebuild,v 1.2 2009/02/15 22:20:59 patrick Exp $

inherit distutils eutils

MY_PN="${PN/#g/G}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="A package for genetic algorithms in Python"
HOMEPAGE="http://home.gna.org/oomadness/en/genetic/"
SRC_URI="http://download.gna.org/oomadness/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PV}-import-future-at-beginning.patch
}
