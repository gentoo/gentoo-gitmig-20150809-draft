# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylibpcap/pylibpcap-0.4.ebuild,v 1.3 2003/06/21 22:30:25 drobbins Exp $

inherit distutils

S=${WORKDIR}/${P}
DESCRIPTION="Python interface to libpcap"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/${PN}/"

IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="virtual/python
	net-libs/libpcap"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins examples/*
}   

