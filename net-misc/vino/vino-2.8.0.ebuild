# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vino/vino-2.8.0.ebuild,v 1.2 2004/09/18 22:35:37 lv Exp $

inherit gnome2

DESCRIPTION="VNC server"
HOMEPAGE="http://www.gnome.org"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="jpeg zlib gnutls crypt"

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/orbit-2
	>=gnome-base/libbonobo-2
	jpeg? ( media-libs/jpeg )
	zlib? ( sys-libs/zlib )
	gnutls? ( >=net-libs/gnutls-1 )
	crypt? ( >=dev-libs/libgcrypt-1.1.90 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

USE_DESTDIR="1"

G2CONF="${G2CONF} \
	`use_with jpeg` \
	`use_with zlib` \
	`use_enable gnutls` \
	`use_enable crypt gcrypt`"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"
