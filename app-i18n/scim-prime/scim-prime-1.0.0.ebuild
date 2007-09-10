# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-prime/scim-prime-1.0.0.ebuild,v 1.3 2007/09/10 16:27:23 opfer Exp $

DESCRIPTION="Japanese input method PRIME IMEngine for SCIM"
HOMEPAGE="http://scim-imengine.sourceforge.jp/index.cgi?cmd=view;name=SCIMPRIME"
SRC_URI="mirror://sourceforge.jp/scim-imengine/19007/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="|| ( >=app-i18n/scim-1.0 >=app-i18n/scim-cvs-1.0 )
	>=app-i18n/prime-1.0.0"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS THANKS README
}

pkg_postinst() {
	elog
	elog "To use SCIM, you should use the following in your user startup scripts"
	elog "such as .gnomerc or .xinitrc:"
	elog
	elog "LANG='your_language' scim -d"
	elog "export XMODIFIERS=@im=SCIM"
	elog "export GTK_IM_MODULE=scim"
	elog "export QT_IM_MODULE=scim"
	elog
}
