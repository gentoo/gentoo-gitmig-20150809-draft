# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyds/pyds-0.7.0.ebuild,v 1.2 2004/02/17 12:19:20 liquidx Exp $

inherit distutils

MY_P="PyDS-${PV}"

DESCRIPTION="Python Desktop Server"
HOMEPAGE="http://pyds.muensterland.org/"
SRC_URI="http://simon.bofh.ms/~gb/${MY_P}.tar.gz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"
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
	>=dev-python/Imaging-1.1.3
	>=dev-python/soappy-0.10.1"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}/PyDS
	epatch ${FILESDIR}/${PN}-0.6.5-py2.3.patch
}
