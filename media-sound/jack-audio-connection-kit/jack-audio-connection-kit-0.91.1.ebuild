# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack-audio-connection-kit/jack-audio-connection-kit-0.91.1.ebuild,v 1.10 2004/07/24 05:51:56 eradicator Exp $

inherit flag-o-matic eutils

IUSE="doc debug jack-tmpfs caps"

DESCRIPTION="A low-latency audio server"
HOMEPAGE="http://jackit.sourceforge.net/"
SRC_URI="mirror://sourceforge/jackit/${P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86 ~ppc"

RDEPEND=">=media-libs/alsa-lib-0.9.1
	>=media-libs/libsndfile-1.0.0
	dev-libs/glib
	dev-util/pkgconfig
	sys-libs/ncurses
	caps? ( sys-libs/libcap )
	!media-sound/jack-cvs"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	sys-devel/autoconf"


src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-doc-option.patch || die "doc configure option failed"
	autoconf || die "Failed regenerating configure"
}

src_compile() {
	local myconf
	local myarch


	myarch=`get-flag -march`

	cd $S
	sed -i "s/^CFLAGS=\$JACK_CFLAGS/CFLAGS=\"\$JACK_CFLAGS $myarch\"/" configure
	use doc \
		&& myconf="--enable-html-docs --with-html-dir=/usr/share/doc/${PF}/" \
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
		rmdir ${D}/usr/share/doc/${PF}/reference
	fi
}
