# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-openid/python-openid-1.2.0.ebuild,v 1.1 2007/02/27 23:29:23 dev-zero Exp $

NEED_PYTHON=2.2

inherit distutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="OpenID support for servers and consumers."
HOMEPAGE="http://www.openidenabled.com/openid/libraries/python/"
SRC_URI="http://www.openidenabled.com/resources/downloads/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc examples"

DEPEND=""
RDEPEND=""

src_install() {
	distutils_src_install
	use doc && dohtml doc/*
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
