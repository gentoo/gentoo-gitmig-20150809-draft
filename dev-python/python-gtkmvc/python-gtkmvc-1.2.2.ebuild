# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-gtkmvc/python-gtkmvc-1.2.2.ebuild,v 1.1 2009/03/08 22:54:20 blackace Exp $

inherit eutils distutils

DESCRIPTION="model-view-controller (MVC) implementation for pygtk"
HOMEPAGE="http://pygtkmvc.sourceforge.net/"
SRC_URI="mirror://sourceforge/pygtkmvc/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4"

RDEPEND="${DEPEND}
	>=dev-python/pygtk-2.4.0"

src_install() {
	distutils_python_version

	site_pkgs="$(python_get_sitedir)"
	export PYTHONPATH="${PYTHONPATH}:${D}/${site_pkgs}"
	dodir ${site_pkgs}

	distutils_src_install
}
