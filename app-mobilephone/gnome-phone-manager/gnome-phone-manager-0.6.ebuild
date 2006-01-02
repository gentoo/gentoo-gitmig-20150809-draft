# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gnome-phone-manager/gnome-phone-manager-0.6.ebuild,v 1.3 2006/01/02 13:53:14 mrness Exp $

inherit gnome2 eutils

DESCRIPTION="a program created to allow you to control aspects of your mobile phone from your GNOME 2 desktop"
HOMEPAGE="http://usefulinc.com/software/phonemgr/"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/${PN}/${PV}/${P}.tar.bz2 "

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2
	>=x11-libs/gtk+-2
	>=gnome-base/libgnome-2
	>=gnome-base/gconf-2
	>=dev-libs/glib-2
	=dev-libs/libsigc++-1.2.5
	>=gnome-base/orbit-2
	>=app-mobilephone/gnokii-0.6.4
	>=net-wireless/bluez-libs-2
	>=net-wireless/libbtctl-0.4.1
	>=gnome-extra/evolution-data-server-1.2.3
	>=net-wireless/gnome-bluetooth-0.5.1"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

DOCS="README NEWS AUTHORS COPYING ChangeLog"
