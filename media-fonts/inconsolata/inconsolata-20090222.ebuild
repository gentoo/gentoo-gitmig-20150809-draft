# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/inconsolata/inconsolata-20090222.ebuild,v 1.2 2010/07/02 16:51:04 darkside Exp $

inherit font

DESCRIPTION="A beautiful sans-serif monotype font designed for code listings"
HOMEPAGE="http://www.levien.com/type/myfonts/inconsolata.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 x86 ~x64-macos"
IUSE=""

FONT_SUFFIX="otf"
FONT_S="${WORKDIR}/${P}"

# Only installs fonts.
RESTRICT="strip binchecks"
