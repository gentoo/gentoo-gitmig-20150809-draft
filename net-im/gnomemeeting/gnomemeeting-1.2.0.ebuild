# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnomemeeting/gnomemeeting-1.2.0.ebuild,v 1.1 2005/01/09 00:26:51 stkn Exp $

inherit gnome2 eutils

DESCRIPTION="Gnome NetMeeting client"
HOMEPAGE="http://www.gnomemeeting.org/"
# now part of gnome-2.4
SRC_URI="http://www.gnomemeeting.org/includes/clicks_counter.php?http://www.gnomemeeting.org/admin/downloads/latest/sources/sources/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="ipv6 sdl ssl howl"

RDEPEND=">=dev-libs/pwlib-1.8.3
	>=net-libs/openh323-1.15.2
	>=net-nds/openldap-2.0.0
	>=gnome-base/libbonoboui-2.2.0
	>=gnome-base/libbonobo-2.2.0
	>=gnome-base/libgnomeui-2.2.0
	>=gnome-base/libgnome-2.2.0
	>=gnome-base/gnome-vfs-2.2.0
	>=gnome-base/gconf-2.2.0
	>=gnome-base/orbit-2.5.0
	>=x11-libs/gtk+-2.4.0
	>=dev-libs/glib-2.0.0
	>=dev-libs/libxml2-2.6.1
	>=media-sound/esound-0.2.28
	gnome-extra/evolution-data-server
	ssl? ( >=dev-libs/openssl-0.9.6g )
	sdl? ( >=media-libs/libsdl-1.2.4 )
	howl? ( >=net-misc/howl-0.9.7 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.20
	dev-lang/perl
	app-text/scrollkeeper"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Fix a hanging bug which shows up when registered to a GateKeeper
	# see http://cvs.gnome.org/viewcvs/gnomemeeting/src/endpoint.cpp?only_with_tag=HEAD&r2=1.434&r1=1.433
	epatch ${FILESDIR}/gnomemeeting-1.2.0-gk-hang-fix.patch
}

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

	econf \
		--prefix=/usr \
		--host=${CHOST} \
		${myconf} \
		$(use_enable howl) \
		$(use_enable ipv6) || die "configure failed"
	emake || die
}

pkg_postinst() {

	gnome2_pkg_postinst
	# we need to fix the GConf permissions, see bug #59764
	# <obz@gentoo.org>
	einfo "Fixing GConf permissions for gnomemeeting"
	gnomemeeting-config-tool --fix-permissions

}

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS FAQ TODO"
