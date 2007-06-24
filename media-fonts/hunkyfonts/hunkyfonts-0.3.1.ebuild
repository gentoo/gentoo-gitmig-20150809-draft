# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/hunkyfonts/hunkyfonts-0.3.1.ebuild,v 1.7 2007/06/24 16:23:09 angelos Exp $

inherit font

IUSE=""

DESCRIPTION="Hunky Fonts are free TrueType fonts based on Bitstream's Vera fonts with additional letters."
HOMEPAGE="http://sourceforge.net/projects/hunkyfonts/"
SRC_URI="mirror://sourceforge/hunkyfonts/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm ia64 ppc s390 sh x86 ~x86-fbsd"

FONT_S="${WORKDIR}/${P}/TTF"
FONT_SUFFIX="ttf"

DOCS="ChangeLog README"
