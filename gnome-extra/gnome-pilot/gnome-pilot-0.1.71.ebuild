# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-pilot/gnome-pilot-0.1.71.ebuild,v 1.4 2003/05/04 11:26:40 liquidx Exp $

IUSE="nls"


S=${WORKDIR}/${P}
DESCRIPTION="Gnome Pilot apps"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/sources/gnome-pilot/0.1/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/gnome-pilot/"

DEPEND="dev-lang/perl
	=gnome-base/control-center-1.4*
	>=gnome-base/gnome-libs-1.4.1.7
	=gnome-base/gnome-panel-1.4*
	>=dev-libs/pilot-link-0.11.0
	=dev-util/gob-1*
	=gnome-base/libglade-0.17*"

RDEPEND="nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc "

src_unpack() {

	unpack ${A}
	cd ${S}
	# USB patch from Mandrake.  Allows gnome-pilot to watch /dev/pilot even
	# when it does not yet exist (because of using devfs).
	patch -p1 < ${FILESDIR}/gnome-pilot-0.1.70-usb.patch
}

src_compile() {

	local myconf

#	use gtk2 \
#		&& CFLAGS="${CFLAGS} `pkg-config --cflags libglade vfs`" \
#		|| CFLAGS="${CFLAGS} `gtk-config --prefix`"

	use nls \
		&& myconf="--enable-nls" \
		|| myconf="--disable-nls"
	
	myconf="${myconf} --enable-usb --with-gnome-libs=/usr/lib"

	
	mkdir intl && touch intl/libgettext.h
	
	econf ${myconf} || die
	
	
	emake || die
}

src_install () {
	einstall || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS
}
