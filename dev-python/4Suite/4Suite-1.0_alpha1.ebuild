# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/4Suite/4Suite-1.0_alpha1.ebuild,v 1.5 2003/08/29 20:32:48 liquidx Exp $

S=${WORKDIR}/${P/_alph/}
DESCRIPTION="Python tools for XML processing and object-databases."
SRC_URI="ftp://ftp.fourthought.com/pub/4Suite/${P/_alph/}.tar.gz"
HOMEPAGE="http://www.4suite.org/"

DEPEND=">=dev-python/pyxml-0.6.5"

SLOT="0"
KEYWORDS="x86 ~sparc ~alpha ~ppc"
LICENSE="as-is"

inherit distutils
