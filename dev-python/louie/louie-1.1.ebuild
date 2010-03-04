# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/louie/louie-1.1.ebuild,v 1.2 2010/03/04 11:24:26 patrick Exp $

inherit distutils

MY_P="Louie-${PV}"
DESCRIPTION="Signal dispatching mechanism for Python"
HOMEPAGE="http://pypi.python.org/pypi/Louie/"
SRC_URI="http://cheeseshop.python.org/packages/source/L/Louie/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

# This has changed with upstream migrating to setuptools. No idea how to actually run them tests now ...
#src_test() {
#	python selftest.py || die "selftest.py failed"
#}
