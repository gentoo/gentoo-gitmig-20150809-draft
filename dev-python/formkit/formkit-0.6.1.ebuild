# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/formkit/formkit-0.6.1.ebuild,v 1.3 2004/11/01 20:10:25 kloeri Exp $

inherit python distutils

S=${WORKDIR}/FormKit
DESCRIPTION="Library to handle server-side www forms. Written for Webware WebKit, it can be used stand-alone as well"
SRC_URI="http://dalchemy.com/global/formkit-0.6.1.tar.bz2"
HOMEPAGE="http://dalchemy.com/opensource/formkit/"

DEPEND="dev-lang/python"

RDEPEND="${DEPEND}
	www-servers/webware" #TODO

IUSE=""
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="-*" #"~x86"

src_compile() {
	cp ${FILESDIR}/${PV}/setup.py . || die
	#python setup.py build || die
}

src_install() {
	python_version
	distutils_src_install
	dodoc License.txt
	insinto /usr/share/doc/${PF}/Examples && doins Examples/*
	insinto /usr/share/doc/${PF}/Docs && doins Docs/*
}

