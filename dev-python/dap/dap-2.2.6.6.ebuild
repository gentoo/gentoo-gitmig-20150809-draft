# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dap/dap-2.2.6.6.ebuild,v 1.1 2008/12/11 19:26:58 bicatali Exp $

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

src_install() {
	distutils_src_install
	dosed -i -e '1idap' \
		/usr/$(get_libdir)/python*/site-packages/dap-*.egg-info/namespace_packages.txt || die
}
