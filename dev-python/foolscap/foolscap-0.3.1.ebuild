# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/foolscap/foolscap-0.3.1.ebuild,v 1.1 2008/09/17 18:29:56 hawking Exp $

inherit distutils

DESCRIPTION="The next-generation RPC protocol, intended to replace Perspective Broker."
HOMEPAGE="http://foolscap.lothar.com/trac"
SRC_URI="http://${PN}.lothar.com/releases/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="dev-python/setuptools"
RDEPEND=">=dev-python/twisted-2.4.0"

src_install() {
	distutils_src_install

	if use doc; then
		dodoc doc/*.txt || die "dodoc failed"
		dohtml -A py,tpl,xhtml -r doc/* || die "dohtml failed"
	fi
}

src_test() {
	PYTHONPATH=. trial ${PN} || die "tests failed"
}
