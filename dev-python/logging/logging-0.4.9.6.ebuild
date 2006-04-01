# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/logging/logging-0.4.9.6.ebuild,v 1.2 2006/04/01 15:06:01 agriffis Exp $

inherit distutils

DESCRIPTION="Logging module for Python"
HOMEPAGE="http://www.red-dove.com/python_logging.html"
SRC_URI="http://www.red-dove.com/logging-${PV}.tar.gz"
LICENSE="logging"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""
DEPEND="virtual/python"
DOCS="liblogging.tex"

src_install() {
	distutils_src_install

	dohtml python_logging.html default.css
	insinto /usr/share/doc/${PF}
	doins -r test
}

