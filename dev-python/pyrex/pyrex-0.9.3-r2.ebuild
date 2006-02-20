# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyrex/pyrex-0.9.3-r2.ebuild,v 1.14 2006/02/20 03:33:48 kumba Exp $

inherit distutils eutils

MY_P="Pyrex-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="a language for writing Python extension modules"
HOMEPAGE="http://www.cosc.canterbury.ac.nz/~greg/python/Pyrex"
SRC_URI="http://www.cosc.canterbury.ac.nz/~greg/python/Pyrex/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE=""

DEPEND="virtual/python"

src_unpack() {
	unpack ${A}
	cd ${S}
	# fix for pyrex distutils for python 2.4. bug# 77042
	epatch ${FILESDIR}/${P}-python24_distutils.patch
	# fix for gcc-4.0
	epatch ${FILESDIR}/${PN}-0.9.2.1-gcc4.patch
}

src_install() {
	mydoc="CHANGES.txt INSTALL.txt README.txt USAGE.txt"
	distutils_src_install

	dodir /usr/share/doc/${PF}/Demos
	cp -r ${S}/Demos ${D}/usr/share/doc/${PF}
	dohtml -r Doc/*
	cp ${S}/Doc/primes.c ${D}usr/share/doc/${PF}/html/
}
