# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-wnn/scim-wnn-0.2.3.ebuild,v 1.1 2005/03/21 09:18:00 usata Exp $

DESCRIPTION="Japanese input method Wnn IMEngine for SCIM"
HOMEPAGE="http://nop.net-p.org/modules/pukiwiki/index.php?%5B%5Bscim-wnn%5D%5D"
SRC_URI="http://nop.net-p.org/files/scim-wnn/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="|| ( >=app-i18n/scim-0.99.8 >=app-i18n/scim-cvs-0.99.8 )
	dev-libs/wnn7sdk
	freewnn? ( app-i18n/freewnn )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	sed -i -e "s:/usr/lib/wnn7:/usr/lib/wnn:g" \
		scim_wnn_def.h wnnconversion.cpp || die "sed failed"
}

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
	if ! use freewnn ; then
	ewarn
	ewarn "You disabled freewnn USE flag."
	ewarn "Please make sure you have wnnenvrc visible to scim-wnn."
	ewarn
	fi
}
