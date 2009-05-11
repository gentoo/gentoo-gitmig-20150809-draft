# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pywebdav/pywebdav-0.9.2.ebuild,v 1.1 2009/05/11 23:04:10 cedk Exp $

PYTHON_MODNAME="DAV DAVServer"

inherit distutils

MY_P=${P/pywebdav/PyWebDAV}

DESCRIPTION="WebDAV server written in python"
HOMEPAGE="http://code.google.com/p/pywebdav/"
SRC_URI="http://pywebdav.googlecode.com/files/${MY_P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""
DEPEND=""
RDEPEND=""
S="${WORKDIR}/${MY_P}"
