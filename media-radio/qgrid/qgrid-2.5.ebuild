# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/qgrid/qgrid-2.5.ebuild,v 1.5 2009/10/01 16:54:18 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde

DESCRIPTION="Amateur radio grid square calculator"
HOMEPAGE="http://users.telenet.be/on4qz/"
SRC_URI="http://users.telenet.be/on4qz/qgrid/download/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc x86"
SLOT="3.5"
LICENSE="GPL-2"
IUSE=""

need-kde 3.5

src_install() {
	kde_src_install
	rm "${D}"/usr/doc -R
	dohtml qgrid/docs/en/*
}
