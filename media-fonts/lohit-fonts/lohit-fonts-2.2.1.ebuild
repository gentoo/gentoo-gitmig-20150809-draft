# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/lohit-fonts/lohit-fonts-2.2.1.ebuild,v 1.1 2008/04/30 02:02:58 dirtyepic Exp $

inherit font

FONT_S="${S}"
FONTDIR="/usr/share/fonts/indic"
FONT_SUFFIX="ttf"

DESCRIPTION="The Lohit family of Indic fonts"
HOMEPAGE="https://fedorahosted.org/lohit"
LICENSE="GPL-2"
SRC_URI="http://rbhalera.fedorapeople.org/released/lohit/${P}.tar.gz"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DOCS="AUTHORS ChangeLog"

RESTRICT="test binchecks"

src_compile() {
	find "${S}" -name "*.ttf" -exec cp "{}" . \;
}
