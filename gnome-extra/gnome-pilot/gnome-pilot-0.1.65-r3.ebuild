# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-pilot/gnome-pilot-0.1.65-r3.ebuild,v 1.10 2003/05/04 11:26:40 liquidx Exp $

IUSE="nls"
S=${WORKDIR}/${P}
DESCRIPTION="Gnome Pilot apps"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/unstable/sources/gnome-pilot/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/gnome-pilot/"

DEPEND="=gnome-base/control-center-1.4*
	>=gnome-base/gnome-libs-1.4.1.7
	=gnome-base/gnome-panel-1.4*
	>=dev-libs/pilot-link-0.9.6
	=dev-util/gob-1*
	=gnome-base/libglade-0.17*"
RDEPEND="nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ppc"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${PN}-gentoo.diff
}

src_compile() {
	local myopts

	CFLAGS="${CFLAGS} `gnome-config --cflags libglade vfs`"

	use nls \
		&& myopts="--enable-nls" \
		|| myopts="--disable-nls"
	
	myopts="${myopts} --enable-usb-visor=yes --with-gnome-libs=/usr/lib"
	
	mkdir intl && touch intl/libgettext.h
	
	econf ${myopts} || die

	emake || die
}

src_install () {
	einstall || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS
}
