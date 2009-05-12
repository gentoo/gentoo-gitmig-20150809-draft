# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xesam-tools/xesam-tools-0.7.0.ebuild,v 1.1 2009/05/12 02:18:24 ford_prefect Exp $

EAPI=2
NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="Development tools and examples for the Xesam desktop search API"
HOMEPAGE="http://xesam.org/people/kamstrup/xesam-tools"
SRC_URI="http://xesam.org/people/kamstrup/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="examples"

DEPEND=""
RDEPEND=">=dev-lang/python-2.4[xml]
	dev-python/dbus-python
	dev-python/pygobject
	dev-python/pygtk"

src_install() {
	distutils_src_install

	insinto "/usr/share/doc/${PF}"
	doins -r samples

	if use examples; then
		insinto "/usr/share/doc/${PF}/demo"
		doins "demo/demo.py"
		insopts -m 0755
		doins demo/[^d]*
	fi
}
