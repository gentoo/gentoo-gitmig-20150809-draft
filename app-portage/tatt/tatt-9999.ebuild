# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/tatt/tatt-9999.ebuild,v 1.1 2010/07/27 12:36:56 fauli Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils git

DESCRIPTION="tatt is an arch testing tool"
HOMEPAGE="http://github.com/tom111/tatt"
EGIT_REPO_URI="git://github.com/tom111/tatt.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="app-portage/eix
		app-portage/gentoolkit
		www-client/pybugz
		dev-python/configobj"

RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${PN}"
