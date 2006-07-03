# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-skk/scim-skk-0.5.2.ebuild,v 1.2 2006/07/03 23:43:14 flameeyes Exp $

DESCRIPTION="Japanese input method SKK IMEngine for SCIM"
HOMEPAGE="http://scim-imengine.sourceforge.jp/index.cgi?cmd=view;name=SCIMSKK"
SRC_URI="mirror://sourceforge.jp/scim-imengine/18121/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

DEPEND="|| ( >=app-i18n/scim-1.2 >=app-i18n/scim-cvs-1.2 )"
RDEPEND="${DEPEND}
	|| ( app-i18n/skk-jisyo virtual/skkserv )
	nls? ( virtual/libintl )"
DEPEND="${DEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

src_compile() {
	econf \
		$(use_enable nls) \
		--disable-dependency-tracking \
		--disable-static || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

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
