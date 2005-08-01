# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-canna/scim-canna-0.1.1.ebuild,v 1.2 2005/08/01 09:34:42 dholm Exp $

DESCRIPTION="Japanese input method Canna IMEngine for SCIM"
HOMEPAGE="http://scim-imengine.sourceforge.jp/index.cgi?cmd=view;name=SCIMCanna"
SRC_URI="mirror://sourceforge.jp/scim-imengine/15825/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="|| ( >=app-i18n/scim-1.0 >=app-i18n/scim-cvs-1.0 )
	>=app-i18n/canna-3.7"

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS THANKS README
}

pkg_postinst() {
	einfo
	einfo "To use SCIM with both GTK2 and XIM, you should use the following"
	einfo "in your user startup scripts such as .gnomerc or .xinitrc:"
	einfo
	einfo "LANG='your_language' scim -d"
	einfo "export GTK_IM_MODULE=scim"
	einfo "export QT_IM_MODULE=scim"
	einfo "export XMODIFIERS=@im=SCIM"
	einfo
}
