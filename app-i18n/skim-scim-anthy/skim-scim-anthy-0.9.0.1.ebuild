# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skim-scim-anthy/skim-scim-anthy-0.9.0.1.ebuild,v 1.1 2006/03/09 23:01:01 flameeyes Exp $

inherit kde

DESCRIPTION="SKIM configuration panel for scim-anthy"
HOMEPAGE="http://scim-imengine.sourceforge.jp/index.cgi?cmd=view;name=SCIMAnthy"
SRC_URI="mirror://sourceforge.jp/scim-imengine/18716/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="|| ( >=app-i18n/scim-1.2 >=app-i18n/scim-cvs-1.2 )
	|| ( >=app-i18n/anthy-5900 >=app-i18n/anthy-ss-5911 )
	app-i18n/skim"
RDEPEND="${DEPEND}
	app-dicts/kasumi"

PATCHES="${FILESDIR}/${P}-qt335.patch"

src_unpack() {
	kde_src_unpack
	rm -f ${S}/configure
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
