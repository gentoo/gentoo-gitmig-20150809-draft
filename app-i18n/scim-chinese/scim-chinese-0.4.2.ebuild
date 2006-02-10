# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-chinese/scim-chinese-0.4.2.ebuild,v 1.10 2006/02/10 19:15:10 liquidx Exp $

inherit gnome2

DESCRIPTION="Smart Common Input Method (SCIM) Smart Pinyin Input Method"
HOMEPAGE="http://www.scim-im.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha ppc amd64 ppc64 ~sparc"

DEPEND="|| ( >=app-i18n/scim-0.9.8 >=app-i18n/scim-cvs-0.9.8 )"

SCROLLKEEPER_UPDATE="0"
G2CONF="--disable-static"
DOCS="AUTHORS NEWS README ChangeLog"
USE_DESTDIR=1
