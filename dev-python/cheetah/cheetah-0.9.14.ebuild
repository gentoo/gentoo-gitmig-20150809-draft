# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cheetah/cheetah-0.9.14.ebuild,v 1.3 2004/06/25 01:26:57 agriffis Exp $

inherit distutils

MY_P=${P/ch/Ch}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Cheetah is a Python-powered template engine and code generator."
SRC_URI="mirror://sourceforge/cheetahtemplate/${MY_P}.tar.gz"
HOMEPAGE="http://www.cheetahtemplate.org/"

DEPEND=">=dev-lang/python-2.2"

SLOT="0"
KEYWORDS="x86 sparc alpha"
LICENSE="PSF-2.2"
IUSE=""

src_install() {
	DOCS="README CHANGES PKG-INFO LICENSE TODO"
	distutils_src_install
	dodir /usr/share/doc/${PF}
	cp -R ${S}/examples ${D}/usr/share/doc/${PF}/
}

