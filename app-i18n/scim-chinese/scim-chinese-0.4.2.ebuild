# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-chinese/scim-chinese-0.4.2.ebuild,v 1.9 2005/02/11 07:11:56 usata Exp $

inherit gnome2

DESCRIPTION="Smart Common Input Method (SCIM) Smart Pinyin Input Method"
HOMEPAGE="http://www.scim-im.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha ppc amd64 ppc64 ~sparc"

DEPEND="virtual/x11
	|| ( >=app-i18n/scim-0.9.8 >=app-i18n/scim-cvs-0.9.8 )"

SCROLLKEEPER_UPDATE="0"
G2CONF="--disable-static"
DOCS="AUTHORS NEWS README ChangeLog"
USE_DESTDIR=1
