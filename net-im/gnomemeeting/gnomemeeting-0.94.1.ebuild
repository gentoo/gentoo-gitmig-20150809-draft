# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnomemeeting/gnomemeeting-0.94.1.ebuild,v 1.10 2004/03/17 00:14:07 stkn Exp $

IUSE="sdl ssl"

inherit gnome2

S="${WORKDIR}/${P}"

SRC_URI="http://www.gnomemeeting.org/downloads/latest/sources/${P}.tar.gz"
HOMEPAGE="http://www.gnomemeeting.org"
DESCRIPTION="Gnome NetMeeting client"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc -sparc "

DEPEND="=dev-libs/pwlib-1.3.11*
	=net-libs/openh323-1.9.10*
	>=net-nds/openldap-2.0.25
	ssl? ( >=dev-libs/openssl-0.9.6g )
	sdl? ( >=media-libs/libsdl-1.2.3 )
	media-libs/speex
	virtual/x11
	gnome-base/libgnomeui
	gnome-base/libbonoboui
	gnome-base/libgnomecanvas
	gnome-base/libgnome
	media-libs/libart_lgpl
	x11-libs/pango
	>=x11-libs/gtk+-2.0.0
	dev-libs/atk
	gnome-base/gnome-vfs
	gnome-base/gconf
	gnome-base/libbonobo
	gnome-base/ORBit2
	dev-libs/popt
	dev-libs/libxml2
	sys-libs/zlib
	net-libs/linc
	>=dev-libs/glib-2.0.0
	media-libs/freetype
	dev-libs/expat
	media-libs/fontconfig
	media-sound/esound"

RDEPEND="${DEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.17"

src_compile() {

	cd ${S}
	local myconf

	use ssl && myconf="--with-openssl-includes=/usr/include/openssl --with-openssl-libs=/usr/lib"

	use sdl && myconf="${myconf} --with-sdl-prefix=/usr" \
		|| myconf="${myconf} --disable-sdltest"

	export PWLIBDIR=/usr/share/pwlib
	export OPENH323DIR=/usr/share/openh323

	econf \
		--with-ptlib-includes=$PWLIBDIR/include/ptlib \
		--with-ptlib-libs=/usr/lib \
		--with-openh323-includes=$OPENH323DIR/include \
		--with-openh323-libs=/usr/lib \
		${myconf} || die "configure failed"

	#manually disable installation of schemas
	cp Makefile Makefile.orig
	sed -e "s/^install-data-local: install-schemas/install-data-local:/g" Makefile.orig > Makefile || die
	make || die
}

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS FAQ TODO"
G2CONF="${G2CONF} --enable-platform-gnome-2"
SCHEMAS="gnomemeeting.schema"


