# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pywebdav/pywebdav-0.8.ebuild,v 1.4 2009/07/27 06:48:08 cedk Exp $

PYTHON_MODNAME="DAV"

inherit distutils

DESCRIPTION="WebDAV server written in python"
HOMEPAGE="http://sourceforge.net/projects/pywebdav/"
SRC_URI="http://pypi.python.org/packages/source/P/PyWebDAV/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""
DEPEND="dev-python/setuptools"
RDEPEND=""
