# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cheetah/cheetah-0.9.17.ebuild,v 1.1 2005/06/15 01:03:03 pythonhead Exp $

inherit distutils

MY_P=${P/ch/Ch}

S=${WORKDIR}/${MY_P}
DESCRIPTION="Python-powered template engine and code generator."
HOMEPAGE="http://www.cheetahtemplate.org/"
SRC_URI="mirror://sourceforge/cheetahtemplate/${MY_P}.tar.gz"

LICENSE="PSF-2.2"
IUSE=""
KEYWORDS="x86 sparc alpha ppc ppc-macos"
SLOT="0"

DEPEND=">=dev-lang/python-2.2"

PYTHON_MODNAME="Cheetah"

src_install() {
	DOCS="README CHANGES LICENSE TODO"
	distutils_src_install

	insinto /usr/share/doc/${PF}/examples
	doins examples/webware_examples/cheetahSite/*
}
