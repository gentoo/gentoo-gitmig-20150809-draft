# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/xsv/xsv-2.5-r1.ebuild,v 1.1 2003/10/30 08:29:42 pythonhead Exp $

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
