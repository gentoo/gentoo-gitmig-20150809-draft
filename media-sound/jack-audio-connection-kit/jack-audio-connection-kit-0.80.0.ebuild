# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack-audio-connection-kit/jack-audio-connection-kit-0.80.0.ebuild,v 1.8 2004/03/27 02:32:17 eradicator Exp $

inherit flag-o-matic eutils

IUSE="doc debug jack-tmpfs"

DESCRIPTION="A low-latency audio server"
HOMEPAGE="http://jackit.sourceforge.net/"
SRC_URI="mirror://sourceforge/jackit/${P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 ppc amd64"

DEPEND=">=media-libs/alsa-lib-0.9.1
	>=media-libs/libsndfile-1.0.0
	dev-libs/glib
	dev-util/pkgconfig
	sys-libs/ncurses
	doc? ( app-doc/doxygen )
	!media-sound/jack-cvs"

PROVIDE="virtual/jack"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-alsalib-fix.patch || \
		die "Alsalib-1.0 patch failed"
	epatch ${FILESDIR}/${PN}-doc-option.patch || \
		die "Documentation configure option patch failed"
	autoconf
}

src_compile() {
	local myconf
	local myarch


	myarch=`get-flag -march`

	cd $S
	sed -i "s/^CFLAGS=\$JACK_CFLAGS/CFLAGS=\"\$JACK_CFLAGS $myarch\"/" configure
	use doc \
		&& myconf="--enable-html-docs --with-html-dir=/usr/share/doc/${PF}/html" \
		|| myconf="--disable-html-docs"

	use jack-tmpfs && myconf="${myconf} --with-default-tmpdir=/dev/shm"
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
