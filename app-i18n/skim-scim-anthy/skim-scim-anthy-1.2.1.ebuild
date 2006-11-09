# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skim-scim-anthy/skim-scim-anthy-1.2.1.ebuild,v 1.1 2006/11/09 15:38:16 matsuu Exp $

inherit kde

DESCRIPTION="SKIM configuration panel for scim-anthy"
HOMEPAGE="http://scim-imengine.sourceforge.jp/index.cgi?cmd=view;name=SCIMAnthy"
SRC_URI="mirror://sourceforge.jp/scim-imengine/21968/${P}.tar.gz
	mirror://gentoo/kde-admindir-3.5.3.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=app-i18n/skim-1.3
	>=app-i18n/scim-anthy-1.2.1"
RDEPEND="${DEPEND}
	app-dicts/kasumi"

PATCHES="${FILESDIR}/${P}-qt335.patch"

pkg_postinst() {
	einfo
	einfo "To use skim, you should use the following in your user startup scripts"
	einfo "such as .gnomerc or .xinitrc:"
	einfo
	einfo "LANG='your_language' skim -d"
	einfo "export XMODIFIERS=@im=SCIM"
	einfo "export GTK_IM_MODULE=scim"
	einfo "export QT_IM_MODULE=scim"
	einfo
}
