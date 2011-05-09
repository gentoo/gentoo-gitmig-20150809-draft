# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/qrencode-python/qrencode-python-1.01.ebuild,v 1.2 2011/05/09 15:47:31 arfrever Exp $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="A simple wrapper for the C qrencode library"
HOMEPAGE="http://pypi.python.org/pypi/qrencode/ https://github.com/Arachnid/pyqrencode/"
SRC_URI="mirror://pypi/q/qrencode/qrencode-${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="Apache-2.0"
IUSE=""

RDEPEND="media-gfx/qrencode"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/qrencode-${PV}

PYTHON_MODNAME="qrencode"
