# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/freefonts/freefonts-0.10-r3.ebuild,v 1.1 2005/10/29 06:36:47 usata Exp $

inherit font

DESCRIPTION="A Collection of Free Type1 Fonts"
SRC_URI="mirror://gimp/fonts/${P}.tar.gz"
HOMEPAGE="http://www.gimp.org"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
LICENSE="freedist"
IUSE="X"

FONT_S=${WORKDIR}/freefont
S=${FONT_S}

FONT_SUFFIX="pfb"
DOCS="README *.license"
