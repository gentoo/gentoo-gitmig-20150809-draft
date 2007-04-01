# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/fonts-indic/fonts-indic-2.1.5.ebuild,v 1.1 2007/04/01 14:14:51 seemant Exp $

inherit font

FONT_S="${S}"
FONT_PN="${PN/fonts-/}"
FONTDIR="/usr/share/fonts/${FONT_PN}"
FONT_SUFFIX="ttf"

DESCRIPTION="The Lohit family of indic fonts"
HOMEPAGE="http://fedoraproject.org/wiki/Lohit"
LICENSE="GPL-2"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DOCS="AUTHORS ChangeLog"

src_compile() {
	find ./ -name '*ttf' -exec  cp {} . \;
}
