# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/xsv/xsv-2.5-r1.ebuild,v 1.2 2004/06/25 01:52:34 agriffis Exp $

inherit distutils

MY_P=${P/xsv/XSV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Python XML Schema Validator"
SRC_URI="ftp://ftp.cogsci.ed.ac.uk/pub/XSV/${MY_P}.tar.gz"
HOMEPAGE="http://www.ltg.ed.ac.uk/~ht/xsv-status.html"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=dev-lang/python-2.2.2
	>=dev-python/pyltxml-1.3"
