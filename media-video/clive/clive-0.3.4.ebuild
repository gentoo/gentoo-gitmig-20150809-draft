# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/clive/clive-0.3.4.ebuild,v 1.1 2007/12/08 13:51:21 aballier Exp $

inherit distutils versionator

DESCRIPTION="Command line tool for extracting videos from Youtube, Google Video, Dailymotion, Guba (free) and Stage6 websites"
HOMEPAGE="http://home.gna.org/clive/"
SRC_URI="http://dl.gna.org/clive/$(get_version_component_range 1-2 ${PV})/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-python/urlgrabber-2.9.9
	>=dev-lang/python-2.4"

src_unpack() {
	distutils_src_unpack

	# dont install man, we'll use doman
	sed -i -e "s/data_files = \[.*\]/data_files = []/" setup.py
}

src_install() {
	distutils_src_install
	doman man/clive.1.gz
}
