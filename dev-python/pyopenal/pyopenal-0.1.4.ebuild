# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyopenal/pyopenal-0.1.4.ebuild,v 1.3 2006/05/09 21:09:09 wolf31o2 Exp $

inherit distutils eutils

MY_P=${P/pyopenal/PyOpenAL}

DESCRIPTION="OpenAL library port for Python"
HOMEPAGE="http://home.gna.org/oomadness/en/pyopenal/"
SRC_URI="http://download.gna.org/pyopenal/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND=">=dev-lang/python-2.2.2
	~media-libs/openal-20050504
	>=dev-python/pyvorbis-1.1
	>=dev-python/pyogg-1.1"

S=${WORKDIR}/${MY_P}

#src_unpack() {
#	unpack ${A}
#	epatch ${FILESDIR}/pyopenal-1.3.patch
#}
