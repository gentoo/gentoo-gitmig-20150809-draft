# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-tomoe/scim-tomoe-0.5.0.ebuild,v 1.1 2007/01/06 05:57:19 matsuu Exp $

DESCRIPTION="Japanese input method Tomoe IMEngine for SCIM"
HOMEPAGE="http://scim-imengine.sourceforge.jp/index.cgi?cmd=view;name=SCIMTomoe"
SRC_URI="mirror://sourceforge.jp/scim-imengine/23343/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( >=app-i18n/scim-1.2.0 >=app-i18n/scim-cvs-1.2.0 )
	>=app-i18n/libtomoe-gtk-0.4.0"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README TODO
}
