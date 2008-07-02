# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dap/dap-2.2.6.4.ebuild,v 1.1 2008/07/02 16:55:11 bicatali Exp $

inherit distutils

DESCRIPTION="Data Access Protocol client and server"
HOMEPAGE="http://pydap.org"

SRC_URI="http://cheeseshop.python.org/packages/source/d/${PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="server"

RDEPEND="dev-python/httplib2
	server? ( dev-python/paste
			  dev-python/pastedeploy
			  dev-python/pastescript
			  dev-python/cheetah )"

DEPEND="${RDEPEND}
	dev-python/setuptools"

DOCS="docs/bugs docs/Changelog docs/history"

src_unpack() {
	distutils_src_unpack
	cd "${S}"
	# removing namespaces in order to avoid annoying warning
	sed -i -e '/namespace_packages/d' setup.py
}
