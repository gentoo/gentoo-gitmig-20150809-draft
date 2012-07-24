# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/croscorefonts/croscorefonts-1.21.0.ebuild,v 1.1 2012/07/24 12:34:14 yngwin Exp $

EAPI=4

inherit font

DESCRIPTION="Open licensed fonts metrically compatible with MS corefonts"
HOMEPAGE="http://www.google.com/webfonts/specimen/Arimo
	http://www.google.com/webfonts/specimen/Cousine
	http://www.google.com/webfonts/specimen/Tinos"
SRC_URI="http://gsdview.appspot.com/chromeos-localmirror/distfiles/${P}.tar.gz"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT="test binchecks"

FONT_SUFFIX="ttf"
FONT_CONF=(
	"${FILESDIR}/62-croscore-arimo.conf"
	"${FILESDIR}/62-croscore-cousine.conf"
	"${FILESDIR}/62-croscore-symbolneu.conf"
	"${FILESDIR}/62-croscore-tinos.conf" )
