# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim-qtkde-helper/uim-qtkde-helper-0.1.0_beta3.ebuild,v 1.1 2004/10/19 15:06:56 usata Exp $

inherit eutils

MY_P="${PN/uim-/}-${PV/_/-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Qt replacement of toolbar, system tray, applet and candidate window for UIM library."
HOMEPAGE="http://freedesktop.org/Software/qtkde-helper"
SRC_URI="http://freedesktop.org/~kzk/qtkde-helper/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-i18n/uim
	>=x11-libs/qt-3.2"

src_compile() {
	addwrite /usr/qt/3/etc/settings

	econf || die "econf failed."
	emake || die "make failed."
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS
}
