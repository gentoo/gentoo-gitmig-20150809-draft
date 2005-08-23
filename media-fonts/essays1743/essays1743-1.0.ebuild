# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/essays1743/essays1743-1.0.ebuild,v 1.3 2005/08/23 21:07:01 gustavoz Exp $

inherit font

MY_PN="Essays1743"

DESCRIPTION="John Stracke's Essays 1743 font"
HOMEPAGE="http://www.thibault.org/fonts/essays/"
SRC_URI="http://www.thibault.org/fonts/essays/${MY_PN}-${PV}-ttf.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_PN}"
FONT_S="${S}"
FONT_SUFFIX="ttf"
