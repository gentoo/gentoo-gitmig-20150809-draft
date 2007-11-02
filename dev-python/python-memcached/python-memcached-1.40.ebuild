# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-memcached/python-memcached-1.40.ebuild,v 1.2 2007/11/02 20:34:01 robbat2 Exp $

inherit distutils

DESCRIPTION="This is a Python based API (implemented in 100% python) for
communicating with the memcached distributed memory object cache daemon."
HOMEPAGE="http://www.tummy.com/Community/software/python-memcached/"
SRC_URI="ftp://ftp.tummy.com/pub/python-memcached/${P}.tar.gz"

LICENSE="OSL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

RDEPEND=">=dev-lang/python-2.4"
DEPEND="${RDEPEND}
		dev-python/setuptools"
