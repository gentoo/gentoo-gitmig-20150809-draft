# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gnome-phone-manager/gnome-phone-manager-0.8-r1.ebuild,v 1.2 2007/11/13 07:48:15 opfer Exp $

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
	# The replace to GTK_ENABLE_DEPRECATED is to not have to deal with the previous line containing a backslash
	sed -e 's/-DGTK_DISABLE_DEPRECATED \\/-DGTK_ENABLE_DEPRECATED/g' -e 's/-DGDK_DISABLE_DEPRECATED \\//g' -e 's/-DG_DISABLE_DEPRECATED//g' \
		-i "${S}/libegg/libegg/Makefile.am" "${S}/libegg/libegg/iconlist/Makefile.am" "${S}/libegg/libegg/tray/Makefile.am"
	eautoreconf
}
