# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/qgrid/qgrid-2.5.ebuild,v 1.4 2008/12/02 15:10:22 darkside Exp $

inherit kde

DESCRIPTION="Amateur radio grid square calculator"
HOMEPAGE="http://users.telenet.be/on4qz/"
SRC_URI="http://users.telenet.be/on4qz/qgrid/download/${P}.tar.gz"

SLOT="0"
KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"
IUSE=""

need-kde 3

src_install() {
	kde_src_install

	rm "${D}"/usr/doc -R
	dohtml qgrid/docs/en/*
}
