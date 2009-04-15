# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/Babel/Babel-0.9.3.ebuild,v 1.3 2009/04/15 20:11:34 maekke Exp $

inherit distutils

DESCRIPTION="A collection of tools for internationalizing Python applications"
HOMEPAGE="http://babel.edgewall.org/"
SRC_URI="http://ftp.edgewall.com/pub/babel/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ia64 x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pytz"

PYTHON_MODNAME="babel"

src_install() {
	distutils_src_install
	dodoc ChangeLog README.txt
	dohtml -r doc/*
}
