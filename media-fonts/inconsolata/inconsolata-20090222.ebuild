# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/inconsolata/inconsolata-20090222.ebuild,v 1.1 2009/02/22 10:33:34 yngwin Exp $

inherit font

DESCRIPTION="A beautiful sans-serif monotype font designed for code listings"
HOMEPAGE="http://www.levien.com/type/myfonts/inconsolata.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

FONT_SUFFIX="otf"
FONT_S="${WORKDIR}/${P}"

# Only installs fonts.
RESTRICT="strip binchecks"
