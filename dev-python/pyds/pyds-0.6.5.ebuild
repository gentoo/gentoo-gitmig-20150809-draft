# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyds/pyds-0.6.5.ebuild,v 1.8 2004/07/19 22:06:47 kloeri Exp $

inherit distutils eutils

MY_P="PyDS-${PV}"

DESCRIPTION="Python Desktop Server"
HOMEPAGE="http://pyds.muensterland.org/"
SRC_URI="http://simon.bofh.ms/~gb/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~x86"
LICENSE="MIT"
IUSE=""

RDEPEND="media-libs/jpeg
	sys-libs/zlib
	>=dev-lang/python-2.2.2
	>=dev-python/medusa-0.5.4
	>=dev-db/metakit-2.4.9.2
	>=dev-python/cheetah-0.9.15
	>=dev-python/pyxml-0.8.2
	>=dev-python/pyrex-0.5
	>=dev-python/docutils-0.3
	>=dev-python/imaging-1.1.3
	>=dev-python/soappy-0.10.1"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}/PyDS
	epatch ${FILESDIR}/${P}-py2.3.patch
}
