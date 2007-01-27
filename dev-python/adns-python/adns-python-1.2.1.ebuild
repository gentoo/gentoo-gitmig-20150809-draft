# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/adns-python/adns-python-1.2.1.ebuild,v 1.1 2007/01/27 22:05:12 lucass Exp $

inherit distutils

DESCRIPTION="Python bindings for ADNS"
HOMEPAGE="http://code.google.com/p/adns-python/"
SRC_URI="http://adns-python.googlecode.com/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND=">=net-libs/adns-1.3"
