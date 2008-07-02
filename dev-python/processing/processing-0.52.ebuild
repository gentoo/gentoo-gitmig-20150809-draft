# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/processing/processing-0.52.ebuild,v 1.3 2008/07/02 02:36:25 chtekk Exp $

NEED_PYTHON=2.4

inherit distutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Package for using processes, which mimics the threading module API."
HOMEPAGE="http://py${PN}.berlios.de/"
SRC_URI="http://cheeseshop.python.org/packages/source/${PN:0:1}/${PN}/${P}.zip"

LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND="!>=dev-lang/python-2.6"

DEPEND="${RDEPEND}
		app-arch/unzip
		dev-python/setuptools"
