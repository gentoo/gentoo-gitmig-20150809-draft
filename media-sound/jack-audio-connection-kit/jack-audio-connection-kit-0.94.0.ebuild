# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack-audio-connection-kit/jack-audio-connection-kit-0.94.0.ebuild,v 1.6 2004/03/27 02:32:17 eradicator Exp $

inherit flag-o-matic eutils

DESCRIPTION="A low-latency audio server"
HOMEPAGE="http://jackit.sourceforge.net/"
SRC_URI="mirror://sourceforge/jackit/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~alpha ~ia64"
IUSE="doc debug jack-tmpfs caps"

DEPEND=">=media-libs/alsa-lib-0.9.1
	>=media-libs/libsndfile-1.0.0
	dev-libs/glib
	dev-util/pkgconfig
	sys-libs/ncurses
	caps? ( sys-libs/libcap )
	doc? ( app-doc/doxygen )
	sys-devel/autoconf
	!media-sound/jack-cvs"
PROVIDE="virtual/jack"

src_unpack() {
	if use jack-caps; then
		eerror "The jack-caps USE flag has been changed to caps.  Please update your environment."
		exit 1
	fi

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-doc-option.patch
	autoconf || die "Couldn't regenerate configure file, failing"
}

src_compile() {
	local myconf
	local myarch

	myarch=`get-flag -march`

	sed -i "s/^CFLAGS=\$JACK_CFLAGS/CFLAGS=\"\$JACK_CFLAGS $myarch\"/" configure
	use doc \
		&& myconf="--enable-html-docs --with-html-dir=/usr/share/doc/${PF}" \
		|| myconf="--disable-html-docs"

	use jack-tmpfs && myconf="${myconf} --with-default-tmpdir=/dev/shm"
	use caps && myconf="${myconf} --enable-capabilities --enable-stripped-jackd"
	use debug && myconf="${myconf} --enable-debug"

	myconf="${myconf} --enable-optimize --with-gnu-ld"

	econf ${myconf} || die "configure failed"
	emake || die "compilation failed"
}

src_install() {
	make DESTDIR=${D} \
		datadir=${D}/usr/share \
		install || die

	if use doc; then
		mv ${D}/usr/share/doc/${PF}/reference/html \
		   ${D}/usr/share/doc/${PF}/
		rm -rf ${D}/usr/share/doc/${PF}/reference
	fi
}
