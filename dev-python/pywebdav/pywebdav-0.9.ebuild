# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pywebdav/pywebdav-0.9.ebuild,v 1.1 2009/04/08 09:39:22 cedk Exp $

PYTHON_MODNAME="DAV"

inherit distutils

MY_P=${P/pywebdav/PyWebDAV}

DESCRIPTION="WebDAV server written in python"
HOMEPAGE="http://sourceforge.net/projects/pywebdav/"
SRC_URI="http://pypi.python.org/packages/source/P/PyWebDAV/${MY_P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""
DEPEND=""
RDEPEND=""
S="${WORKDIR}/${MY_P}"
