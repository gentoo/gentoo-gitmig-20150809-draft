# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyopenal/pyopenal-0.1.6.ebuild,v 1.7 2007/01/06 12:19:57 dev-zero Exp $

inherit distutils eutils

MY_P=${P/pyopenal/PyOpenAL}

DESCRIPTION="OpenAL library port for Python"
HOMEPAGE="http://home.gna.org/oomadness/en/pyopenal/"
SRC_URI="http://download.gna.org/pyopenal/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.2.2
	>=dev-python/pyvorbis-1.1
	>=dev-python/pyogg-1.1
	media-libs/openal
	media-libs/freealut"

S=${WORKDIR}/${MY_P}

DOCS="AUTHORS CHANGES"
src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-setup.patch || die "patching"
}
