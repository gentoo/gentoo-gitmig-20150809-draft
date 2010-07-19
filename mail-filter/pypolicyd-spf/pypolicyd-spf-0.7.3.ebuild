# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/pypolicyd-spf/pypolicyd-spf-0.7.3.ebuild,v 1.3 2010/07/19 01:00:44 dragonheart Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"

inherit distutils eutils versionator

DESCRIPTION="Python based policy daemon for Postfix SPF checking"
SRC_URI="http://launchpad.net/pypolicyd-spf/$(get_version_component_range 1-2)/${PV}/+download/${P}.tar.gz"
HOMEPAGE="https://launchpad.net/pypolicyd-spf"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-python/pyspf-2.0.3"

src_prepare() {
	sed -i -e 's/[\xc2\xa9]//g' policydspfsupp.py policydspfuser.py policyd-spf
	distutils_src_prepare
}
