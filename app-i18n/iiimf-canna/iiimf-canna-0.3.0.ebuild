# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/iiimf-canna/iiimf-canna-0.3.0.ebuild,v 1.1 2004/09/13 20:25:58 usata Exp $

DESCRIPTION="Canna Language Engine input method module for IIIMF"
HOMEPAGE="http://www.momonga-linux.org/~famao/iiimf-skk/"
SRC_URI="mirror://sourceforge.jp/iiimf-skk/5752/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gtk2 nls"

DEPEND="virtual/libc
	>=sys-libs/db-3
	gtk2? ( >=x11-libs/gtk+-2 )
	!gtk2? ( =x11-libs/gtk+-1.2* )
	dev-libs/libxml2
	app-i18n/im-sdk
	app-i18n/canna"

src_compile() {

	econf \
		`use_enable nls` \
		`use_enable gtk2` || die
	make || die
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS AUTHORS ChangeLog INSTALL NEWS README TODO

	newbin ${FILESDIR}/iiimf-canna.sh iiimf-canna
}
