# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/turbokid/turbokid-1.0.4.ebuild,v 1.1 2008/01/04 18:06:51 hawking Exp $

NEED_PYTHON=2.4

inherit distutils

MY_PN="TurboKid"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python template plugin that supports Kid templates"
HOMEPAGE="http://www.turbogears.org/docs/plugins/template.html"
SRC_URI="http://cheeseshop.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="test"
S="${WORKDIR}/${MY_P}"
RDEPEND=">=dev-python/kid-0.9.6"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( dev-python/nose )"

src_test() {
	PYTHONPATH=. "${python}" setup.py test || die "tests failed"
}
