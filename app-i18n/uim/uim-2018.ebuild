# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim/uim-2018.ebuild,v 1.2 2003/09/07 17:43:33 usata Exp $

DESCRIPTION="UIM an input method library"
HOMEPAGE="http://anthy.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/anthy/5577/${P}.tar.gz"

LICENSE="GPL-2 | BSD"
KEYWORDS="x86 ~sparc"
SLOT="0"
IUSE="gtk nls canna"

S="${WORKDIR}/${P}"

DEPEND="virtual/glibc
	gtk? ( >=x11-libs/gtk+-2 )
	canna? ( app-i18n/canna )"

src_compile() {
	econf \
		`use_with gtk` \
		`use_enable nls` \
		`use_with canna` || die
	emake || die
}

src_install () {
	einstall || die

	dodoc AUTHORS ChangeLog COPYING INSTALL* NEWS README*
}
