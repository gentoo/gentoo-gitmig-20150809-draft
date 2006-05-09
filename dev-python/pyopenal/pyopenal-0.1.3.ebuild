# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyopenal/pyopenal-0.1.3.ebuild,v 1.7 2006/05/09 21:09:09 wolf31o2 Exp $

inherit distutils eutils

MY_P=${P/pyopenal/PyOpenAL}

DESCRIPTION="OpenAL library port for Python"
HOMEPAGE="http://oomadness.tuxfamily.org/en/pyopenal/"
SRC_URI="http://oomadness.tuxfamily.org/downloads/${MY_P}.tar.gz
	http://www.nectroom.homelinux.net/pkg/${MY_P}.tar.gz
	http://nectroom.homelinux.net/pkg/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=">=dev-lang/python-2.2.2
	~media-libs/openal-20050504
	>=dev-python/pyvorbis-1.1
	>=dev-python/pyogg-1.1"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/pyopenal-1.3.patch
}
