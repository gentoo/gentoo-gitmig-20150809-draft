# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyrex/pyrex-0.9.3-r1.ebuild,v 1.4 2005/04/01 18:14:38 blubb Exp $

inherit distutils eutils

MY_P="Pyrex-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="a language for writing Python extension modules"
HOMEPAGE="http://www.cosc.canterbury.ac.nz/~greg/python/Pyrex"
SRC_URI="http://www.cosc.canterbury.ac.nz/~greg/python/Pyrex/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ia64 ~mips ~ppc ~sparc x86 ~ppc64"
IUSE=""

DEPEND="virtual/python"

src_unpack() {
	unpack ${A}
	cd ${S}
	# fix for pyrex distutils for python 2.4. bug# 77042
	epatch ${FILESDIR}/${P}-python24_distutils.patch
}

src_install() {
	mydoc="CHANGES.txt INSTALL.txt README.txt USAGE.txt"
	distutils_src_install

	dodir /usr/share/doc/${PF}/Demos
	cp -r ${S}/Demos ${D}/usr/share/doc/${PF}
	dohtml -r Doc/*
	cp ${S}/Doc/primes.c ${D}usr/share/doc/${PF}/html/
}
