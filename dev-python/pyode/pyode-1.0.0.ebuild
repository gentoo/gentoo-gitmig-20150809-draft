# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyode/pyode-1.0.0.ebuild,v 1.2 2005/01/25 01:12:54 lucass Exp $

inherit distutils

MY_P="${P/pyode/PyODE}"
DESCRIPTION="python bindings to the ode physics engine"
HOMEPAGE="http://pyode.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyode/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/python
		>=dev-games/ode-0.5
		>=dev-python/pyrex-0.9.3"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/odepath.patch"
}
