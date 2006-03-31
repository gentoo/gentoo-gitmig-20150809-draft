# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/logging/logging-0.4.9.6.ebuild,v 1.1 2006/03/31 16:24:16 lucass Exp $

inherit distutils

DESCRIPTION="Logging module for Python"
HOMEPAGE="http://www.red-dove.com/python_logging.html"
SRC_URI="http://www.red-dove.com/logging-${PV}.tar.gz"
LICENSE="logging"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
DEPEND="virtual/python"
DOCS="liblogging.tex"

src_install() {
	distutils_src_install

	dohtml python_logging.html default.css
	insinto /usr/share/doc/${PF}
	doins -r test
}

