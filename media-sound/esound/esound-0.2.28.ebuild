# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/esound/esound-0.2.28.ebuild,v 1.1 2002/06/19 16:32:49 stroke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The Enlightened Sound Daemon"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/esound/${P}.tar.bz2
ftp://download.sourceforge.net/pub/mirrors/gnome/stable/sources/esound/${P}.tar.bz2"
HOMEPAGE="http://www.tux.org/~ricdude/EsounD.html"
SLOT="0"

DEPEND="virtual/glibc
	>=media-libs/audiofile-0.1.9
	alsa? ( >=media-libs/alsa-lib-0.5.9 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r2 )"

RDEPEND="virtual/glibc
	>=media-libs/audiofile-0.1.9
	alsa? ( >=media-libs/alsa-lib-0.5.9 )"

src_compile() {
	libtoolize --copy --force

	local myconf=""
	use tcpd && myconf="${myconf} --with-libwrap" \
		|| myconf="${myconf} --without-libwrap"

	use alsa && myconf="${myconf} --enable-alsa" \
		|| myconf="${myconf} --enable-alsa=no"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc/esd \
		${myconf} || die

	make || die
}

src_install() {                               
	make prefix=${D}/usr sysconfdir=${D}/etc/esd install || die

	dodoc AUTHORS COPYING* ChangeLog README TODO NEWS TIPS
	dodoc docs/esound.ps

	dohtml docs/html/*.html
}

