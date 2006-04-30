# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythonutils/pythonutils-0.2.5.ebuild,v 1.1 2006/04/30 19:55:36 lucass Exp $

inherit eutils distutils

DESCRIPTION="Voidspace python modules"
HOMEPAGE="http://www.voidspace.org.uk/python/pythonutils.html"
SRC_URI="http://www.voidspace.org.uk/cgi-bin/voidspace/downman.py?file=${P}.zip"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2
		app-arch/unzip"

src_install() {
	distutils_src_install

	dodoc MANIFEST PKG-INFO README "${S}"/docs/*.txt
	dohtml -r "${S}"/docs/{*.html,images,smilies,stylesheets}
}
