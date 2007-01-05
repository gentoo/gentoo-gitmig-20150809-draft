# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/iiimf-canna/iiimf-canna-0.3.0.ebuild,v 1.5 2007/01/05 16:17:55 flameeyes Exp $

DESCRIPTION="Canna Language Engine input method module for IIIMF"
HOMEPAGE="http://www.momonga-linux.org/~famao/iiimf-skk/"
SRC_URI="mirror://sourceforge.jp/iiimf-skk/5752/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"

DEPEND="virtual/libc
	>=sys-libs/db-3
	>=x11-libs/gtk+-2
	dev-libs/libxml2
	app-i18n/im-sdk
	app-i18n/canna"

src_compile() {

	econf \
		`use_enable nls` \
		--enable-gtk2 || die
	emake -j1 || die
}

src_install() {

	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS AUTHORS ChangeLog INSTALL NEWS README TODO

	newbin ${FILESDIR}/iiimf-canna.sh iiimf-canna
}

pkg_postinst() {

	elog
	elog "To use this module, follow these steps:"
	elog "(1) run /etc/init.d/iiim start (as root)"
	elog "(2) run iiimf-canna (as normal user)"
	elog "(3) export XMODIFIERS='@im=htt' (setenv XMODIFIERS '@im=htt' in csh)"
	elog
}
