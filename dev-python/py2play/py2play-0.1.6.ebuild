# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py2play/py2play-0.1.6.ebuild,v 1.2 2004/06/12 07:22:22 mr_bones_ Exp $

inherit distutils

MY_P=${P/py2play/Py2Play}
DESCRIPTION="A Peer To Peer network game engine"
HOMEPAGE="http://oomadness.nekeme.net/en/py2play/"
SRC_URI="http://oomadness.tuxfamily.org/downloads/${MY_P}.tar.gz
	http://www.nectroom.homelinux.net/pkg/${MY_P}.tar.gz
	http://nectroom.homelinux.net/pkg/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2.2"

S="${WORKDIR}/${MY_P}"
