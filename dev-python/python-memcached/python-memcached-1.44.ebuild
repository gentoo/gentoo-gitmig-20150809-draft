# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-memcached/python-memcached-1.44.ebuild,v 1.6 2010/03/26 02:48:00 sping Exp $

NEED_PYTHON="2.4"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A Python based API (implemented in 100% python) for
communicating with the memcached distributed memory object cache daemon."
HOMEPAGE="http://www.tummy.com/Community/software/python-memcached/"
SRC_URI="ftp://ftp.tummy.com/pub/python-memcached/old-releases/${P}.tar.gz"

LICENSE="OSL-2.0"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

RESTRICT_PYTHON_ABIS="3*"

pkg_postinst() {
	python_mod_optimize memcache.py
}
