# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim/uim-2013.ebuild,v 1.1 2003/08/17 11:31:19 usata Exp $

IUSE="gtk canna"

DESCRIPTION="UIM is a universal input method library"
HOMEPAGE="http://anthy.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/anthy/5495/${P}.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/x11
	gtk? ( >=x11-libs/gtk+-2.2.1 )
	canna? ( >=app-i18n/canna-3.5_beta2-r2 )"

S=${WORKDIR}/${P}

src_compile() {

	CPPFLAGS="${CPPFLAGS} -I.." econf \
		`use_with gtk` \
		`use_with canna` || die
	emake || die
}

src_install() {

	einstall || die

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL* NEWS README*
}
