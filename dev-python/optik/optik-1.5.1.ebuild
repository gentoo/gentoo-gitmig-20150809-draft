# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/optik/optik-1.5.1.ebuild,v 1.1 2009/09/07 20:32:47 patrick Exp $

inherit distutils

IUSE=""
DESCRIPTION="Optik is a powerful, flexible, easy-to-use command-line parsing library for Python."
SRC_URI="mirror://sourceforge/optik/${P}.tar.gz"
HOMEPAGE="http://optik.sourceforge.net/"

DEPEND="virtual/python"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
LICENSE="BSD"

src_install() {
	DOCS="*.txt"
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins examples/*
}
