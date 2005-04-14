# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/optik/optik-1.5.ebuild,v 1.1 2005/04/14 18:26:00 kloeri Exp $

inherit distutils

IUSE=""
DESCRIPTION="Optik is a powerful, flexible, easy-to-use command-line parsing library for Python."
SRC_URI="mirror://sourceforge/optik/${P}.tar.gz"
HOMEPAGE="http://optik.sourceforge.net/"

DEPEND="virtual/python"

SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ~ppc ~amd64"
LICENSE="BSD"

mydoc="*.txt"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins examples/*
}
