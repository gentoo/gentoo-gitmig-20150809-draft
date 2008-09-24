# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/freefont-ttf/freefont-ttf-20080912.ebuild,v 1.1 2008/09/24 20:19:32 loki_val Exp $

inherit font

DESCRIPTION="TrueType Unicode fonts from the Free UCS Outline Fonts Project"
HOMEPAGE="http://savannah.nongnu.org/projects/freefont/"
SRC_URI="mirror://gnu/freefont/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE=""

FONT_SUFFIX="ttf"
S="${WORKDIR}/freefont-${PV}"
FONT_S="${S}"
DOCS="CREDITS"

RESTRICT="strip binchecks"
