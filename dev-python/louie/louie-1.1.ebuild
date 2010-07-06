# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/louie/louie-1.1.ebuild,v 1.3 2010/07/06 15:41:48 ssuominen Exp $

inherit distutils

MY_P="Louie-${PV}"
DESCRIPTION="Signal dispatching mechanism for Python"
HOMEPAGE="http://pypi.python.org/pypi/Louie/"
SRC_URI="http://cheeseshop.python.org/packages/source/L/Louie/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

# This has changed with upstream migrating to setuptools. No idea how to actually run them tests now ...
#src_test() {
#	python selftest.py || die "selftest.py failed"
#}
