# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnomemeeting/gnomemeeting-0.98.0.ebuild,v 1.11 2005/01/09 00:26:51 stkn Exp $

IUSE="sdl ssl ipv6"

inherit gnome.org gnome2

HOMEPAGE="http://www.gnomemeeting.org"
DESCRIPTION="Gnome NetMeeting client"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc -sparc"

DEPEND=">=dev-libs/pwlib-1.5.0
	>=net-libs/openh323-1.12.0
	>=net-nds/openldap-2.0.25
	ssl? ( >=dev-libs/openssl-0.9.6g )
	sdl? ( >=media-libs/libsdl-1.2.4 )
	>=gnome-base/libbonoboui-2.0
	>=gnome-base/libbonobo-2.0
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/libgnome-2.0
	>=net-libs/linc-0.5.0
	>=x11-libs/gtk+-2.0.0
	>=dev-libs/glib-2.0.0
	>=gnome-base/gconf-2.0
	>=dev-libs/libxml2-2.4.23
	>=media-sound/esound-0.2.28
	>=gnome-base/orbit-2.5.0"

RDEPEND="${DEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.20
	dev-lang/perl"

MAKEOPTS="${MAKEOPTS} -j1"

src_compile() {

	local myconf

	myconf="${myconf} --with-ptlib-includes=/usr/include/ptlib"
	myconf="${myconf} --with-ptlib-libs=/usr/lib"
	myconf="${myconf} --with-openh323-includes=/usr/include/openh323"
	myconf="${myconf} --with-openh323-libs=/usr/lib"

	if use ssl; then
		myconf="${myconf} --with-openssl-libs=/usr/lib"
		myconf="${myconf} --with-openssl-includes=/usr/include/openssl"
	fi

	use sdl \
		&& myconf="${myconf} --with-sdl-prefix=/usr" \
		|| myconf="${myconf} --disable-sdltest"

	use ipv6 \
		&& myconf="${myconf} --enable-ipv6" \
		|| myconf="${myconf} --disable-ipv6"

	econf ${myconf} || die "configure failed"
	emake || die
}

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS FAQ TODO"
