# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnomemeeting/gnomemeeting-0.93.1.ebuild,v 1.4 2002/09/18 14:41:13 raker Exp $

inherit gnome2

S="${WORKDIR}/GnomeMeeting-${PV}"

SRC_URI="http://www.gnomemeeting.org/downloads/latest/sources/GnomeMeeting-${PV}.tar.gz"
HOMEPAGE="http://www.gnomemeeting.org"
DESCRIPTION="Gnome NetMeeting client"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc -sparc64"

DEPEND="=dev-libs/pwlib-1.3.3*
	=net-libs/openh323-1.9.3*
	>=net-nds/openldap-2.0.25
	>=gnome-base/gnome-2.0.1
	ssl? ( >=dev-libs/openssl-0.9.6g )
	sdl? ( >=media-libs/libsdl-1.2.3 )"

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
	
															
