# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gnome-phone-manager/gnome-phone-manager-0.4.ebuild,v 1.3 2005/07/21 21:24:41 mrness Exp $

inherit gnome2 eutils

DESCRIPTION="Gnome Phone Manager - a program created to allow you to control aspects of your mobile phone from your GNOME 2 desktop"
HOMEPAGE="http://usefulinc.com/software/phonemgr/"
SRC_URI="http://downloads.usefulinc.com/gnome-phone-manager/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2
	>=x11-libs/gtk+-2
	>=gnome-base/libgnome-2
	>=gnome-base/gconf-2
	>=dev-libs/glib-2
	=dev-libs/libsigc++-1.2.5
	>=gnome-base/orbit-2
	>=app-mobilephone/gsmlib-1.11_pre041028
	>=net-wireless/bluez-libs-2
	>=net-wireless/libbtctl-0.4.1
	>=net-wireless/gnome-bluetooth-0.5.1"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

DOCS="README NEWS AUTHORS COPYING ChangeLog"
MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc3.patch
}
