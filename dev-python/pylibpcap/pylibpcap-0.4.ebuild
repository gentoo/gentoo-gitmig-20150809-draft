# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylibpcap/pylibpcap-0.4.ebuild,v 1.4 2003/06/22 12:15:59 liquidx Exp $

inherit distutils

S=${WORKDIR}/${P}
DESCRIPTION="Python interface to libpcap"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/${PN}/"

IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/python
	net-libs/libpcap"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins examples/*
}   

