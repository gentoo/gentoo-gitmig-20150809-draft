# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/tex2im/tex2im-1.8.ebuild,v 1.2 2005/05/15 07:11:03 pclouds Exp $

DESCRIPTION="shell script that renders latex formulae to a wide variety of image
formats"
HOMEPAGE="http://www.nought.de/tex2im.php"
SRC_URI="http://www.nought.de/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="virtual/tetex
	media-gfx/imagemagick"

src_install() {
	exeinto /usr/bin
	doexe tex2im
	dodoc README CHANGELOG LICENSE examples/*
}
