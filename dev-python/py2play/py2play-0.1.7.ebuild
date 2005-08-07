# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py2play/py2play-0.1.7.ebuild,v 1.3 2005/08/07 13:18:36 hansmi Exp $

inherit distutils

MY_P=${P/py2play/Py2Play}
DESCRIPTION="A Peer To Peer network game engine"
HOMEPAGE="http://home.gna.org/oomadness/en/slune"
SRC_URI="http://download.gna.org/slune/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2.2"

S="${WORKDIR}/${MY_P}"
