# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/argparse/argparse-1.0.1.ebuild,v 1.1 2009/10/20 19:46:33 djc Exp $

SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Provides an easy, declarative interface for creating command line tools."
HOMEPAGE="http://code.google.com/p/argparse/"
SRC_URI="http://argparse.googlecode.com/files/${P}.zip"
LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"
