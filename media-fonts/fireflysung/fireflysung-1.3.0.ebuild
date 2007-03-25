# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/fireflysung/fireflysung-1.3.0.ebuild,v 1.7 2007/03/25 11:40:28 armin76 Exp $

inherit font

DESCRIPTION="Chinese TrueType FireFly Fonts"
HOMEPAGE="http://www.study-area.org/apt/firefly-font/"
SRC_URI="http://www.study-area.org/apt/firefly-font/${P}.tar.gz"

LICENSE="Arphic"
SLOT="0"
KEYWORDS="~amd64 arm ~hppa ia64 ~ppc s390 sh x86 ~x86-fbsd"
IUSE=""

FONT_S="${S}"
FONT_SUFFIX="ttf"
DOCS="AUTHORS Changelog* COPYRIGHT"

# Only installs fonts
RESTRICT="strip binchecks"
