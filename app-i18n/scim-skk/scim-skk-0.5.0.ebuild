# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-skk/scim-skk-0.5.0.ebuild,v 1.2 2006/10/16 18:26:53 flameeyes Exp $

DESCRIPTION="Japanese input method SKK IMEngine for SCIM"
HOMEPAGE="http://scim-imengine.sourceforge.jp/index.cgi?cmd=view;name=SCIMSKK"
SRC_URI="mirror://sourceforge.jp/scim-imengine/17701/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="|| ( >=app-i18n/scim-1.2 >=app-i18n/scim-cvs-1.2 )"
RDEPEND="${DEPEND}
	|| ( app-i18n/skk-jisyo virtual/skkserv )"
DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS THANKS README
}

pkg_postinst() {
	einfo
	einfo "To use SCIM, you should use the following in your user startup scripts"
	einfo "such as .gnomerc or .xinitrc:"
	einfo
	einfo "LANG='your_language' scim -d"
	einfo "export XMODIFIERS=@im=SCIM"
	einfo "export GTK_IM_MODULE=scim"
	einfo "export QT_IM_MODULE=scim"
	einfo
}
