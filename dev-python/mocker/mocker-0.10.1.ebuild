# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mocker/mocker-0.10.1.ebuild,v 1.2 2008/08/31 04:20:32 mr_bones_ Exp $

inherit distutils

DESCRIPTION="Platform for Python test doubles: mocks, stubs, fakes, and dummies"
HOMEPAGE="http://labix.org/mocker"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"
LICENSE="PSF-2.4"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

src_test() {
	PYTHONPATH=. "${python}" test.py || die "Tests failed"
}
