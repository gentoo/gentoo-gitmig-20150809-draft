# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/unidecode/unidecode-0.04.9.ebuild,v 1.3 2012/05/28 23:21:18 jdhore Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS=""

inherit distutils

S="${WORKDIR}/Unidecode-${PV}"

DESCRIPTION="Module providing ASCII transliterations of Unicode text"
HOMEPAGE="http://pypi.python.org/pypi/Unidecode"
SRC_URI="mirror://pypi/U/Unidecode/Unidecode-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
