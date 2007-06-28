# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/kacst-fonts/kacst-fonts-1.6.2.ebuild,v 1.8 2007/06/28 02:15:27 angelos Exp $

inherit font

MY_PN="KacstArabicFonts"
S=${WORKDIR}/${MY_PN}-${PV}

DESCRIPTION="KACST Arabic TrueType Fonts"
HOMEPAGE="http://www.arabeyes.org/project.php?proj=Khotot"
SRC_URI="mirror://sourceforge/arabeyes/${P//-/_}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 arm ia64 ppc s390 sh ~x86 ~x86-fbsd"
IUSE=""

FONT_SUFFIX="ttf"

DOCS="LICENSE.TXT"

FONT_S=${S}
