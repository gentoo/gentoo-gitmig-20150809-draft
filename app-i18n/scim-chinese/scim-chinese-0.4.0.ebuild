# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-chinese/scim-chinese-0.4.0.ebuild,v 1.4 2004/07/17 16:33:06 usata Exp $

inherit gnome2

DESCRIPTION="Smart Common Input Method (SCIM) Smart Pinyin Input Method"
HOMEPAGE="http://freedesktop.org/~suzhe/"
SRC_URI="http://freedesktop.org/~suzhe/${PN}/${P}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/x11
	|| ( >=app-i18n/scim-0.9.0 app-i18n/scim-cvs )"

SCROLLKEEPER_UPDATE="0"
G2CONF="--disable-static"
DOCS="AUTHORS NEWS README ChangeLog"
USE_DESTDIR=1
