# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pydispatcher/pydispatcher-1.0.1.ebuild,v 1.4 2008/08/06 05:46:21 neurogeek Exp $

inherit distutils

MY_PN="PyDispatcher"

DESCRIPTION="Multi-producer-multi-consumer signal dispatching mechanism for Python"
HOMEPAGE="http://pydispatcher.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"

IUSE=""
DEPEND="virtual/python"

S="${WORKDIR}/${MY_PN}-${PV}"

src_install() {
	distutils_src_install
	distutils_python_version
	dohtml -r "${D}/$(python_get_sitedir)"/dispatch/docs/*
	rm -r "${D}/$(python_get_sitedir)/dispatch/docs"
}
