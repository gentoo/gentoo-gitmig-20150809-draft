# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gnome-phone-manager/gnome-phone-manager-0.8.ebuild,v 1.4 2007/08/18 07:04:59 mrness Exp $

inherit gnome2 eutils autotools

DESCRIPTION="a program created to allow you to control aspects of your mobile phone from your GNOME 2 desktop"
HOMEPAGE="http://live.gnome.org/PhoneManager"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/${PN}/${PV}/${P}.tar.bz2 "

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2
	>=x11-libs/gtk+-2
	>=gnome-base/libgnome-2
	>=gnome-base/gconf-2
	>=dev-libs/glib-2
	>=gnome-base/orbit-2
	>=dev-libs/openobex-1
	>=app-mobilephone/gnokii-0.6.12
	>=net-wireless/bluez-libs-2.25
	>=gnome-extra/evolution-data-server-1.2.3
	>=net-wireless/gnome-bluetooth-0.7.0-r1"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

DOCS="README NEWS AUTHORS ChangeLog"

src_unpack() {
	gnome2_src_unpack

	epatch "${FILESDIR}/${P}-pixmaps.patch"
	epatch "${FILESDIR}/${P}-as-needed.patch"
	eautoreconf
}
