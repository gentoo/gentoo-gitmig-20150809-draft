# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libvncserver/libvncserver-0.6.ebuild,v 1.3 2004/04/05 05:10:07 vapier Exp $

inherit eutils

X11VNC_VER=20040101
DESCRIPTION="library for creating vnc servers"
HOMEPAGE="http://libvncserver.sourceforge.net/"
SRC_URI="mirror://sourceforge/libvncserver/LibVNCServer-${PV}.tar.gz
	 http://dev.gentoo.org/~plasmaroo/patches/vnc/${P}-${X11VNC_VER}-x11vnc.c.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa"
IUSE="nobackchannel no24bpp zlib jpeg"

DEPEND="virtual/x11
	zlib? ( sys-libs/zlib )
	jpeg? ( media-libs/jpeg )"

S=${WORKDIR}/LibVNCServer-${PV}

src_unpack() {
	unpack LibVNCServer-${PV}.tar.gz
	cd ${S}
	sed -i "/^CFLAGS/s:-g:${CFLAGS}:" Makefile.in */Makefile.in
	cd contrib
	unpack ${P}-${X11VNC_VER}-x11vnc.c.bz2
}

src_compile() {
	local myconf=""
	[ `use nobackchannel` ] \
		&& myconf="${myconf} --without-backchannel" \
		|| myconf="${myconf} --with-backchannel"
	[ `use no24bpp` ] \
		&& myconf="${myconf} --without-24bpp" \
		|| myconf="${myconf} --with-24bpp"
	econf \
		`use_with zlib` \
		`use_with jpeg` \
		${myconf} \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dobin examples/storepasswd
	dodoc AUTHORS ChangeLog NEWS README TODO
}
