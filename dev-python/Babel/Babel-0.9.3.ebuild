# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/Babel/Babel-0.9.3.ebuild,v 1.1 2008/07/23 18:06:08 cedk Exp $

inherit distutils

DESCRIPTION="A collection of tools for internationalizing Python applications"
HOMEPAGE="http://babel.edgewall.org/"
SRC_URI="http://ftp.edgewall.com/pub/babel/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pytz"

PYTHON_MODNAME="babel"

src_install() {
	distutils_src_install
	dodoc ChangeLog README.txt
	dohtml -r doc/*
}
