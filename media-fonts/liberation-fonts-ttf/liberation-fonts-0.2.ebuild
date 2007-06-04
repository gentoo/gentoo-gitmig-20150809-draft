# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/liberation-fonts-ttf/liberation-fonts-0.2.ebuild,v 1.1 2007/06/04 08:30:22 je_fro Exp $

inherit font
MY_P="${PN}-ttf"
MY_PV="3"

DESCRIPTION="A GPL-2 TrueType font replacement, courtesy of Red Hat."
SRC_URI="https://www.redhat.com/f/fonts/${MY_P}-${MY_PV}.tar.gz"
HOMEPAGE="http://www.redhat.com"
KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2-with-exceptions"
IUSE="X"

FONT_S=${S}
FONT_SUFFIX="ttf"

DOCS="License.txt"
