# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-wnn/scim-wnn-1.0.0.ebuild,v 1.1 2006/06/29 00:37:34 usata Exp $

DESCRIPTION="Japanese input method Wnn IMEngine for SCIM"
HOMEPAGE="http://nop.net-p.org/modules/pukiwiki/index.php?%5B%5Bscim-wnn%5D%5D"
SRC_URI="http://nop.net-p.org/files/scim-wnn/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="freewnn"

RDEPEND="|| ( >=app-i18n/scim-1.0 >=app-i18n/scim-cvs-1.0 )
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
