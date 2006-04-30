# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-pinyin/scim-pinyin-0.5.91.ebuild,v 1.7 2006/04/30 11:49:25 blubb Exp $

inherit kde-functions gnome2

DESCRIPTION="Smart Common Input Method (SCIM) Smart Pinyin Input Method"
HOMEPAGE="http://www.scim-im.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.gz"

IUSE="arts"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 ~sparc x86"

DEPEND="|| ( x11-libs/libXt virtual/x11 )
	|| ( >=app-i18n/scim-1.1 >=app-i18n/scim-cvs-1.1 )
	arts? ( kde-base/arts )"

SCROLLKEEPER_UPDATE="0"
G2CONF="--disable-static $(use_with arts)"
DOCS="AUTHORS NEWS README ChangeLog"
USE_DESTDIR=1
