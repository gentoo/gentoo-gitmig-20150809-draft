# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-unikey/ibus-unikey-0.5.ebuild,v 1.1 2010/06/15 17:56:12 matsuu Exp $

EAPI="2"

DESCRIPTION="Vietnamese Input Method Engine for IBUS using Unikey IME"
HOMEPAGE="http://code.google.com/p/ibus-unikey/"
SRC_URI="http://ibus-unikey.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-i18n/ibus-1.2
	gnome-base/gconf:2
	>=x11-libs/gtk+-2.12:2
	x11-libs/libX11"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README || die
}
