# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/m2crypto/m2crypto-0.07_alpha3.ebuild,v 1.7 2004/11/04 16:38:44 pythonhead Exp $

DESCRIPTION="A python wrapper for the OpenSSL crypto library"
HOMEPAGE="http://www.post1.com/home/ngps/m2/"
MY_P=${P/_alpha/-snap}
SRC_URI="http://www.post1.com/home/ngps/m2/${MY_P}.zip"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
DEPEND="dev-libs/openssl
	app-arch/unzip"
S=${WORKDIR}/${MY_P}
IUSE=""

inherit distutils

src_install () {
	mydoc=""
	distutils_src_install
	# can't dodoc, doesn't handle subdirs
	dodir /usr/share/doc/${PF}/example
	cp -a demo/* ${D}/usr/share/doc/${PF}/example
	dodoc BUGS CHANGES STORIES
	dohtml -r doc/*
}
