# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/Cheetah/Cheetah-0.9.15_alpha3.ebuild,v 1.4 2003/06/22 12:15:59 liquidx Exp $

DESCRIPTION="Python-powered template engine and code generator."
HOMEPAGE="http://www.cheetahtemplate.org/"
LICENSE="PSF-2.2"

KEYWORDS="~x86 ~sparc ~alpha"
SLOT="0"

RDEPEND=">=dev-lang/python-2.2"
DEPEND="${RDEPEND}"

SRC_URI="mirror://sourceforge/cheetahtemplate/${P/_alpha/a}.tar.gz"
S=${WORKDIR}/${P/_alpha/a}

src_compile() {

	python setup.py build || die

}

src_install() {

	python setup.py install --prefix=${D}/usr || die
	dodoc CHANGES LICENSE PKG-INFO README TODO

	# What's the best way to deal with the examples?
	tar zcvf examples.tar.gz examples
	dodoc examples.tar.gz

}
