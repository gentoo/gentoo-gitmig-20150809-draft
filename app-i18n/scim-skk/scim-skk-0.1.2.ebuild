# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-skk/scim-skk-0.1.2.ebuild,v 1.3 2005/04/04 13:33:21 matsuu Exp $

DESCRIPTION="Japanese input method SKK IMEngine for SCIM"
HOMEPAGE="http://scim-imengine.sourceforge.jp/index.cgi?cmd=view;name=SCIMSKK"
SRC_URI="mirror://sourceforge.jp/scim-imengine/12875/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND="|| ( >=app-i18n/scim-0.99.8 >=app-i18n/scim-cvs-0.99.8 )"

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
	einfo "export XMODIFIERS=@im=SCIM"
	einfo
}
