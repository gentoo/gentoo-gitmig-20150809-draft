# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/freefont-ttf/freefont-ttf-20060126.ebuild,v 1.4 2008/01/23 18:15:16 armin76 Exp $

inherit font

DESCRIPTION="TrueType Unicode fonts from the Free UCS Outline Fonts Project"
HOMEPAGE="http://savannah.nongnu.org/projects/freefont/"
SRC_URI="http://download.savannah.nongnu.org/releases/freefont/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc x86"

FONT_SUFFIX="ttf"
S="${WORKDIR}/freefont-${PV}"
FONT_S="${S}"
DOCS="CREDITS"

RESTRICT="strip binchecks"
