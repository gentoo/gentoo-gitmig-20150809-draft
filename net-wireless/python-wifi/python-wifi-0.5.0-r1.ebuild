# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/python-wifi/python-wifi-0.5.0-r1.ebuild,v 1.3 2011/03/30 16:16:06 jer Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Provides r/w access to a wireless network card's capabilities using the Linux Wireless Extensions"
HOMEPAGE="http://pypi.python.org/pypi/python-wifi https://developer.berlios.de/projects/pythonwifi"
SRC_URI="mirror://berlios/${PN/-}/${P}.tar.bz2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~x86"
LICENSE="LGPL-2.1 examples? ( GPL-2 )"
IUSE="examples"

RDEPEND=""
DEPEND="dev-python/setuptools"

DOCS="docs/AUTHORS docs/BUGS docs/DEVEL.txt docs/TODO"
PYTHON_MODNAME="pythonwifi"

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/${P}/
		doins -r examples || die "no examples"
	fi
	rm -rvf "${ED}"/usr/{docs,examples,INSTALL,README} || die
	mv -v "${ED}"/usr{,/share}/man || die
}
