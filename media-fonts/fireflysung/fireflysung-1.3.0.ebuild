# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/fireflysung/fireflysung-1.3.0.ebuild,v 1.1 2005/12/04 04:27:44 usata Exp $

inherit font

DESCRIPTION="Chinese TrueType FireFly Fonts"
HOMEPAGE="http://www.study-area.org/apt/firefly-font/"
SRC_URI="http://www.study-area.org/apt/firefly-font/${P}.tar.gz"

LICENSE="Arphic"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

FONT_S="${S}"
FONT_SUFFIX="ttf"
DOCS="AUTHORS Changelog* COPYRIGHT"
