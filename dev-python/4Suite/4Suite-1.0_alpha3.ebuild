# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/4Suite/4Suite-1.0_alpha3.ebuild,v 1.2 2003/10/08 10:06:40 liquidx Exp $

inherit distutils

S=${WORKDIR}/${PN}
DESCRIPTION="Python tools for XML processing and object-databases."
SRC_URI="ftp://ftp.fourthought.com/pub/4Suite/${P/_alph/}.tar.gz"
HOMEPAGE="http://www.4suite.org/"

DEPEND=">=dev-python/pyxml-0.6.5"

SLOT="0"
KEYWORDS="x86 ~sparc ~alpha ~ppc"
LICENSE="as-is"
IUSE=""

