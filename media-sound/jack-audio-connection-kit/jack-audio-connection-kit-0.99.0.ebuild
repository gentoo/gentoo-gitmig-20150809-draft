# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack-audio-connection-kit/jack-audio-connection-kit-0.99.0.ebuild,v 1.11 2004/11/12 08:44:34 eradicator Exp $

IUSE="altivec alsa caps doc debug jack-tmpfs oss portaudio"

inherit flag-o-matic eutils

DESCRIPTION="A low-latency audio server"
HOMEPAGE="http://jackit.sourceforge.net/"
SRC_URI="mirror://sourceforge/jackit/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~mips ~ppc ~ppc64 ~ppc-macos sparc x86"

RDEPEND=">=media-libs/libsndfile-1.0.0
	dev-libs/glib
	dev-util/pkgconfig
	sys-libs/ncurses
	!ppc64? ( !alpha? ( !ia64? ( portaudio? ( media-libs/portaudio ) ) ) )
	!sparc? ( alsa? ( >=media-libs/alsa-lib-0.9.1 ) )
	caps? ( sys-libs/libcap )
	!media-sound/jack-cvs"

DEPEND="${RDEPEND}
	!ppc-macos? ( sys-devel/autoconf )
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd ${S}

	if use !ppc-macos ; then
		# Add doc option and fix --march=pentium2 in caps test
		epatch ${FILESDIR}/${PN}-0.98.1-configure.patch && WANT_AUTOCONF=2.5 autoconf \
			|| die
	fi
}

src_compile() {
	local myconf
	local myarch

	myarch=`get-flag -march`

	sed -i "s/^CFLAGS=\$JACK_CFLAGS/CFLAGS=\"\$JACK_CFLAGS $myarch\"/" configure
	use doc \
		&& myconf="--enable-html-docs --with-html-dir=/usr/share/doc/${PF}" \
		|| myconf="--disable-html-docs"

	if use jack-tmpfs; then
		myconf="${myconf} --with-default-tmpdir=/dev/shm"
	else
		myconf="${myconf} --with-default-tmpdir=/var/run/jack"
	fi

	use caps && myconf="${myconf} --enable-capabilities --enable-stripped-jackd"
	use debug && myconf="${myconf} --enable-debug"
	myconf="${myconf} --enable-optimize --with-gnu-ld"

	myconf="${myconf} `use_enable altivec` `use_enable alsa` `use_enable oss` `use_enable portaudio`"

	econf ${myconf} || die "configure failed"
	emake || die "compilation failed"
}

src_install() {
	make DESTDIR=${D} \
		datadir=${D}/usr/share \
		install || die

	if ! use jack-tmpfs; then
		keepdir /var/run/jack
		chmod 4777 ${D}/var/run/jack
	fi

	if use doc; then
		mv ${D}/usr/share/doc/${PF}/reference/html \
		   ${D}/usr/share/doc/${PF}/
	fi

	rm -rf ${D}/usr/share/doc/${PF}/reference
}

#pkg_postinst() {
#	einfo "Because of some ABI changes in jack, you may need to re-emerge."
#	einfo "packages that use jack by running the following:"
#	einfo "  revdep-rebuild --soname libjack.so.0"
#}
