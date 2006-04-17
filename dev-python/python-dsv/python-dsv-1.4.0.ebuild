# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-dsv/python-dsv-1.4.0.ebuild,v 1.1 2006/04/17 21:39:20 mrness Exp $

inherit distutils

DESCRIPTION="Python module for importing and exporting DSV files"
HOMEPAGE="http://python-dsv.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/DSV-${PV}.tar.gz"

LICENSE="CNRI"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/wxpython-2.6.3.2"

S="${WORKDIR}/DSV-${PV}"
