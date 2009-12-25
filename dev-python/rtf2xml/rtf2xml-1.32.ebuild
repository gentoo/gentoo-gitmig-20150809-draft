# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rtf2xml/rtf2xml-1.32.ebuild,v 1.2 2009/12/25 13:08:58 hwoarang Exp $

inherit distutils

DESCRIPTION="Converts a Microsoft RTF file to structured XML"
HOMEPAGE="http://rtf2xml.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/python"

src_install() {
	distutils_src_install

	dohtml docs/html/*
}
