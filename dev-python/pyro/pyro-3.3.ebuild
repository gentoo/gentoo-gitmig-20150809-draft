# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyro/pyro-3.3.ebuild,v 1.2 2004/02/17 00:42:04 kloeri Exp $

inherit distutils

DESCRIPTION="Pyro is an advanced and powerful Distributed Object Technology system written entirely in Python"

MY_P="Pyro-${PV}"
S=${WORKDIR}/${MY_P}
HOMEPAGE="http://pyro.sourceforge.net"
LICENSE="MIT"
SRC_URI="mirror://sourceforge/pyro/${MY_P}.tar.gz"

DEPEND="virtual/python"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_unpack () {
	unpack ${A}
	epatch ${FILESDIR}/${P}-unattend.patch
}

src_install () {
	distutils_src_install

	dodir /usr/share/doc/${PF}/examples
	cp -r ${S}/examples ${D}/usr/share/doc/${PF}
	dohtml -r docs/*
}
