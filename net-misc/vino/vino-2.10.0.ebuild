# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vino/vino-2.10.0.ebuild,v 1.10 2005/08/25 00:40:45 agriffis Exp $

inherit gnome2

DESCRIPTION="VNC server"
HOMEPAGE="http://www.gnome.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
#IUSE="jpeg zlib gnutls crypt"
IUSE="jpeg gnutls crypt"

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeui-2.5.2
	>=gnome-base/orbit-2
	>=gnome-base/libbonobo-2
	sys-libs/zlib
	jpeg? ( media-libs/jpeg )
	gnutls? ( >=net-libs/gnutls-1 )
	crypt? ( >=dev-libs/libgcrypt-1.1.90 )"
#	zlib? ( sys-libs/zlib )

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

USE_DESTDIR="1"

G2CONF="${G2CONF} \
	--with-zlib \
	$(use_with jpeg) \
	$(use_enable gnutls) \
	$(use_enable crypt gcrypt)"
#	$(use_with zlib) \

DOCS="AUTHORS ChangeLog NEWS README"
