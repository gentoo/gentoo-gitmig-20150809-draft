# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/farsi-fonts/farsi-fonts-0.4.ebuild,v 1.5 2006/09/03 06:25:44 vapier Exp $

inherit font

S=${WORKDIR}/${P/-/}

DESCRIPTION="Farsi (Persian) TrueType fonts"
HOMEPAGE="http://www.arabeyes.org/project.php?proj=Khotot"
SRC_URI="mirror://sourceforge/arabeyes/${P//-/_}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 arm ~hppa ia64 ~ppc s390 sh ~x86"
IUSE=""

FONT_SUFFIX="ttf"
FONT_S="${S}"

DOCS="NEWS.txt"
