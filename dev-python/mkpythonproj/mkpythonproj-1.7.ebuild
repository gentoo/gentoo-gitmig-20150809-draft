# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mkpythonproj/mkpythonproj-1.7.ebuild,v 1.2 2010/02/08 08:42:19 pva Exp $

EAPI="2"
inherit eutils distutils

DESCRIPTION="Creates the framework for a new Python project or script."
HOMEPAGE="http://www.seanet.com/~hgg9140/comp/mkpythonproj/doc/index.html"
SRC_URI="http://www.seanet.com/~hgg9140/comp/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
DEPEND="virtual/python"
RDEPEND="${DEPEND}"

src_prepare(){
	epatch "${FILESDIR}/${PN}_licenses.patch"
}
