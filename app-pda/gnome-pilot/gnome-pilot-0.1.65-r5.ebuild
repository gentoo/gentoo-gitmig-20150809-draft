# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gnome-pilot/gnome-pilot-0.1.65-r5.ebuild,v 1.2 2003/08/30 10:13:23 liquidx Exp $

DESCRIPTION="Gnome Pilot apps"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/unstable/sources/gnome-pilot/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/gnome-pilot/"


RDEPEND="dev-lang/perl
	=gnome-base/control-center-1.4*
	>=gnome-base/gnome-libs-1.4.1.7
	=gnome-base/gnome-panel-1.4*
	>=app-pda/pilot-link-0.11.0
	=dev-util/gob-1*
	=gnome-base/libglade-0.17*"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"


IUSE="nls"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${PN}-gentoo.diff
}

src_compile() {

	local myconf

	use nls \
		&& myconf="--enable-nls" \
		|| myconf="--disable-nls"
	
	myconf="${myconf} --enable-usb-visor=yes --with-gnome-libs=/usr/lib"
	
	mkdir intl && touch intl/libgettext.h
	
	econf ${myconf} || die
	
	perl -pi -e 's/PISOCK_LIBS = -lpisock/PISOCK_LIBS = -lpisock -lpisync/g' \
		`find . -name Makefile`

	
	emake || die
}

src_install () {
	einstall || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS
}
