# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack-audio-connection-kit/jack-audio-connection-kit-0.91.1.ebuild,v 1.2 2003/12/18 22:07:29 mholzer Exp $

inherit flag-o-matic

IUSE="doc debug jack-tmpfs jack-caps"

DESCRIPTION="A low-latency audio server"
HOMEPAGE="http://jackit.sourceforge.net/"
SRC_URI="mirror://sourceforge/jackit/${P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86 ~ppc"

DEPEND=">=media-libs/alsa-lib-0.9.1
	>=media-libs/libsndfile-1.0.0
	dev-libs/glib
	dev-util/pkgconfig
	sys-libs/ncurses
	jack-caps? ( sys-libs/libcap )
	doc? ( app-doc/doxygen )
	!media-sound/jack-cvs"

PROVIDE="virtual/jack"



src_compile() {
	local myconf
	local myarch


	myarch=`get-flag -march`

	cd $S
	sed -i "s/^CFLAGS=\$JACK_CFLAGS/CFLAGS=\"\$JACK_CFLAGS $myarch\"/" configure
	use doc \
		&& myconf="--with-html-dir=/usr/share/doc/${PF}/html" \
		|| myconf="--without-html-dir"

	use jack-tmpfs && myconf="${myconf} --with-default-tmpdir=/dev/shm"
	use jack-caps && myconf="${myconf} --enable-capabilities --enable-stripped-jackd"
	use debug && myconf="${myconf} --enable-debug"

	myconf="${myconf} --enable-optimize --with-gnu-ld"

	econf ${myconf} || die "configure failed"
	emake || die "compilation failed"
}

src_install() {

	use doc && dodir /usr/share/doc/${PF}/html

	make DESTDIR=${D} \
		datadir=${D}/usr/share \
		install || die

	use doc && mv \
		${D}/usr/share/jack-audio-connection-kit/reference/html/* \
		${D}/usr/share/doc/${PF}/html
	use doc && rm -rf ${D}/usr/share/jack-audio-connection-kit
}
