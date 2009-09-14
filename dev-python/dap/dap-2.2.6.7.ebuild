# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dap/dap-2.2.6.7.ebuild,v 1.2 2009/09/14 02:45:56 bicatali Exp $

EAPI=2
inherit eutils distutils

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

src_prepare() {
	sed -i \
		-e "s/'dap.plugins'/'dap','dap.plugins'/" \
		setup.py  || die
}

