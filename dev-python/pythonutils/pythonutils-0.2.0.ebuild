# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythonutils/pythonutils-0.2.0.ebuild,v 1.1 2005/09/03 18:27:42 g2boojum Exp $

inherit eutils distutils
DESCRIPTION="Voidspace python modules"
HOMEPAGE="http://www.voidspace.org.uk/python/pythonutils.html"
SRC_URI="http://www.voidspace.org.uk/cgi-bin/voidspace/downman.py?file=${P}.zip"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2
		app-arch/unzip"

src_compile() {
	distutils_src_compile
}

src_install() {
	mydoc="MANIFEST PKG-INFO README"
	distutils_src_install
	dodoc ${S}/docs/*.txt
	dohtml -r ${S}/docs/{*.html,images,smilies,stylesheets}
}
