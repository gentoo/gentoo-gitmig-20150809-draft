# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-hangul/scim-hangul-0.0.2.ebuild,v 1.2 2004/08/04 09:33:58 dholm Exp $

DESCRIPTION="Hangul IMEngine for SCIM ported from imhangul"
HOMEPAGE="http://scim.freedesktop.org/ScimHangul"
SRC_URI="http://freedesktop.org/~suzhe/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="|| ( >=app-i18n/scim-0.99.0 app-i18n/scim-cvs )"

src_compile() {
	econf || die
	emake || die
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
}
