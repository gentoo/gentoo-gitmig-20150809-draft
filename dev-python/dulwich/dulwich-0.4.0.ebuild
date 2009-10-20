# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dulwich/dulwich-0.4.0.ebuild,v 1.1 2009/10/20 08:55:33 djc Exp $

SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Dulwich is a pure-Python implementation of the Git file formats and protocols."
HOMEPAGE="http://samba.org/~jelmer/dulwich/"
SRC_URI="http://samba.org/~jelmer/dulwich/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"
