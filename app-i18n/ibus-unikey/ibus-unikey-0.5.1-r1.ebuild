# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-unikey/ibus-unikey-0.5.1-r1.ebuild,v 1.1 2011/05/28 01:56:00 matsuu Exp $

EAPI="3"
inherit eutils

DESCRIPTION="Vietnamese Input Method Engine for IBUS using Unikey IME"
HOMEPAGE="http://code.google.com/p/ibus-unikey/"
SRC_URI="http://ibus-unikey.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-i18n/ibus-1.3.99
	gnome-base/gconf:2
	>=x11-libs/gtk+-2.12:2
	x11-libs/libX11"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	# http://pkgs.fedoraproject.org/gitweb/?p=ibus-unikey.git
	epatch "${FILESDIR}/${PN}-ibus-1.4.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README || die
}
