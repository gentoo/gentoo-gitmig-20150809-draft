# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyprotocols/pyprotocols-0.9.3.ebuild,v 1.5 2007/11/16 19:32:56 drac Exp $

inherit distutils multilib

MY_P="${P/pypro/PyPro}"
SRC_URI="http://peak.telecommunity.com/dist/${MY_P}.tar.gz"
DESCRIPTION="Adapter/protocol framework for Python"
HOMEPAGE="http://peak.telecommunity.com/PyProtocols.html"
LICENSE="ZPL"

SLOT="0"
IUSE=""
KEYWORDS="amd64 ~ia64 ~ppc x86"
S="${WORKDIR}/${MY_P}"

src_test() {
	PYTHONPATH="${T}/test/$(get_libdir)/python" "${python}" setup.py \
		install --home="${T}/test" test || die "Unit tests failed!"
}
