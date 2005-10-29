# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/hunkyfonts/hunkyfonts-0.3.1.ebuild,v 1.1 2005/10/29 03:23:48 usata Exp $

inherit font

IUSE=""

DESCRIPTION="Hunky Fonts are free TrueType fonts based on Bitstream's Vera fonts with additional letters."
HOMEPAGE="http://sourceforge.net/projects/hunkyfonts/"
SRC_URI="mirror://sourceforge/hunkyfonts/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

FONT_S="${WORKDIR}/${P}/TTF"
FONT_SUFFIX="ttf"

DOCS="ChangeLog README"
