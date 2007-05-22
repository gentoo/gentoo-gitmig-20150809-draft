# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/liberation-fonts-ttf/liberation-fonts-ttf-2.ebuild,v 1.1 2007/05/22 01:17:02 je_fro Exp $

inherit font

DESCRIPTION="A GPL-2 TrueType font replacement, courtesy of Red Hat."
SRC_URI="https://www.redhat.com/f/fonts/${P}.tar.gz"
HOMEPAGE="http://www.redhat.com"
KEYWORDS="~amd64"
SLOT="0"
LICENSE="GPL-2-with-exceptions"
IUSE="X"

S=${WORKDIR}
FONT_S=${S}
FONT_SUFFIX="ttf"

DOCS="License.txt"
