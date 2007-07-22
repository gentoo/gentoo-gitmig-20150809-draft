# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-pinyin/scim-pinyin-0.5.91.ebuild,v 1.10 2007/07/22 09:25:03 calchan Exp $

inherit kde-functions gnome2

DESCRIPTION="Smart Common Input Method (SCIM) Smart Pinyin Input Method"
HOMEPAGE="http://www.scim-im.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 ~sparc x86"

RDEPEND="x11-libs/libXt
	|| ( >=app-i18n/scim-1.1 >=app-i18n/scim-cvs-1.1 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

SCROLLKEEPER_UPDATE="0"
G2CONF="--disable-static --without-arts"
DOCS="AUTHORS NEWS README ChangeLog"
USE_DESTDIR=1

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-qt335.patch"
}
