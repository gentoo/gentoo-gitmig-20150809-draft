# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-anthy/scim-anthy-1.2.4.ebuild,v 1.3 2007/09/10 16:22:08 opfer Exp $

inherit libtool

DESCRIPTION="Japanese input method Anthy IMEngine for SCIM"
HOMEPAGE="http://scim-imengine.sourceforge.jp/index.cgi?cmd=view;name=SCIMAnthy"
SRC_URI="mirror://sourceforge.jp/scim-imengine/25404/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86 ~x86-fbsd"
IUSE="kde nls"

DEPEND="|| ( >=app-i18n/scim-1.2 >=app-i18n/scim-cvs-1.2 )
	|| ( >=app-i18n/anthy-5900 >=app-i18n/anthy-ss-5911 )
	nls? ( virtual/libintl )"
RDEPEND="${DEPEND}
	app-dicts/kasumi"
DEPEND="${DEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"
PDEPEND="kde? ( app-i18n/skim-scim-anthy )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	elibtoolize
}

src_compile() {
	econf \
		$(use_enable nls) \
		--disable-static \
		--disable-dependency-tracking || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

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
