# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyro/pyro-3.3.ebuild,v 1.3 2004/04/25 21:29:17 vapier Exp $

inherit distutils eutils

MY_P="Pyro-${PV}"
DESCRIPTION="advanced and powerful Distributed Object Technology system written entirely in Python"
HOMEPAGE="http://pyro.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyro/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/python"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-unattend.patch
}

src_install() {
	distutils_src_install

	dodir /usr/share/doc/${PF}/examples
	cp -r ${S}/examples ${D}/usr/share/doc/${PF}
	dohtml -r docs/*
}
