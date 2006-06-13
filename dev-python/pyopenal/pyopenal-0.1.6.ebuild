# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyopenal/pyopenal-0.1.6.ebuild,v 1.1 2006/06/13 21:08:44 wolf31o2 Exp $

inherit distutils eutils

MY_P=${P/pyopenal/PyOpenAL}

DESCRIPTION="OpenAL library port for Python"
HOMEPAGE="http://home.gna.org/oomadness/en/pyopenal/"
SRC_URI="http://download.gna.org/pyopenal/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.2.2
	>=dev-python/pyvorbis-1.1
	>=dev-python/pyogg-1.1
	|| (
		(
			|| (
				~media-libs/openal-0.0.8
				~media-libs/openal-20051024 )
			media-libs/freealut )
		~media-libs/openal-20050504 )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-setup.patch || die "patching"
	if has_version ~media-libs/openal-20050504
	then
		sed -i 's/, "alut"//' setup.py || die "sed"
	fi
}
