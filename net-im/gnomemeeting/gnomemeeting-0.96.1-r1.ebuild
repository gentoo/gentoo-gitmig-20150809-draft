# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnomemeeting/gnomemeeting-0.96.1-r1.ebuild,v 1.2 2003/05/16 23:33:29 liquidx Exp $

IUSE="sdl ssl ipv6 gnome"
inherit gnome2

S="${WORKDIR}/${P}"
SRC_URI="http://www.gnomemeeting.org/downloads/latest/sources/${P}.tar.gz"
HOMEPAGE="http://www.gnomemeeting.org"
DESCRIPTION="Gnome NetMeeting client"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc -sparc"
DEPEND=">=dev-libs/pwlib-1.4.11
	>=net-libs/openh323-1.11.7
	>=net-nds/openldap-2.0.25
	ssl? ( >=dev-libs/openssl-0.9.6g )
	sdl? ( >=media-libs/libsdl-1.2.4 )
    gnome? ( >=gnome-base/libbonoboui-2.0
    	>=gnome-base/libbonobo-2.0
    	>=gnome-base/libgnomeui-2.0
        >=gnome-base/libgnome-2.0
		>=net-libs/linc-0.5.0 )
	>=x11-libs/gtk+-2.0.0
	>=dev-libs/glib-2.0.0    
	>=gnome-base/gconf-2.0
	>=dev-libs/libxml2-2.4.23
	>=media-sound/esound-0.2.28 
    >=gnome-base/ORBit2-2.5.0"

RDEPEND="${DEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.20
	dev-lang/perl"

src_unpack() {
	unpack ${A}
    # backported patch from CVS. remove this in next release.
    epatch ${FILESDIR}/${P}-pwcworkaround.patch || die "patch failed"
}

src_compile() {

	local myconf
	export PWLIBDIR=/usr/share/pwlib
	export OPENH323DIR=/usr/share/openh323
    
    myconf="${myconf} --with-ptlib-includes=${PWLIBDIR}/include/ptlib"
    myconf="${myconf} --with-ptlib-libs=/usr/lib"
    myconf="${myconf} --with-openh323-includes=${OPENH323DIR}/include"
    myconf="${myconf} --with-openh323-libs=/usr/lib"
    
    if [ -n "`use ssl`" ]; then
		myconf="${myconf} --with-openssl-libs=/usr/lib"
		myconf="${myconf} --with-openssl-includes=/usr/include/openssl"
    fi
    
	use sdl && myconf="${myconf} --with-sdl-prefix=/usr" \
		|| myconf="${myconf} --disable-sdltest"
	use ipv6 && myconf="${myconf} --enable-ipv6" \
    	|| myconf="${myconf} --disable-ipv6"
	use gnome || myconf="${myconf} --disable-gnome"
        
    econf ${myconf} || die "configure failed"
    make || die
}

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS FAQ TODO"
G2CONF="${G2CONF} --enable-platform-gnome-2"
SCHEMAS="gnomemeeting.schema"
	
															
