# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libosmocore/libosmocore-9999.ebuild,v 1.1 2012/06/15 13:51:23 chithanh Exp $

EAPI="4"
inherit autotools

if [[ ${PV} == 9999* ]]; then
	inherit git-2
	SRC_URI=""
	EGIT_REPO_URI="git://git.osmocom.org/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="http://cgit.osmocom.org/cgit/libosmocore/snapshot/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Utility functions for OsmocomBB, OpenBSC and related projects"
HOMEPAGE="http://bb.osmocom.org/trac/wiki/libosmocore"

LICENSE="GPL-2 LGPL-3"
SLOT="0"
IUSE="embedded"

RDEPEND=""
DEPEND="${RDEPEND}
	app-doc/doxygen"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_enable embedded)
}

src_install() {
	default
	# install to correct documentation directory
	mv "${ED}"/usr/share/doc/${PN}/${PN}-* "${ED}"/usr/share/doc/${PF} || die
	rmdir "${ED}"/usr/share/doc/${PN}/ || die
}
