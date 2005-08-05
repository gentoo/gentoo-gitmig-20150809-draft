# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack-audio-connection-kit/jack-audio-connection-kit-0.100.0.ebuild,v 1.1 2005/08/05 20:25:22 kito Exp $

inherit flag-o-matic eutils multilib

DESCRIPTION="A low-latency audio server"
HOMEPAGE="http://jackit.sourceforge.net/"
SRC_URI="mirror://sourceforge/jackit/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="-alpha -amd64 -hppa -ia64 -mips ~ppc ~ppc-macos -ppc64 -sparc -x86"
IUSE="altivec alsa caps coreaudio doc debug jack-tmpfs mmx oss pic portaudio sndfile sse"

RDEPEND="dev-util/pkgconfig
	sndfile? ( >=media-libs/libsndfile-1.0.0 )
	sys-libs/ncurses
	caps? ( sys-libs/libcap )
	!ppc64? ( !alpha? ( !ia64? ( portaudio? ( =media-libs/portaudio-18* ) ) ) )
	!sparc? ( alsa? ( >=media-libs/alsa-lib-0.9.1 ) )
	!media-sound/jack-cvs"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

pkg_setup() {
	if ! use sndfile ; then
		ewarn "sndfile not in USE flags. jack_rec will not be installed!"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# the docs option is in upstream, I'll leave the pentium2 foobage
	# for the x86 folks...... kito@gentoo.org

	# Add doc option and fix --march=pentium2 in caps test
	#epatch ${FILESDIR}/${PN}-doc-option.patch

	# compile and install jackstart, see #92895, #94887
	if use caps ; then
		epatch ${FILESDIR}/${P}-jackstart.patch
	fi

	epatch ${FILESDIR}/${PN}-transport.patch
}

src_compile() {
	local myconf

	sed -i "s/^CFLAGS=\$JACK_CFLAGS/CFLAGS=\"\$JACK_CFLAGS $(get-flag -march)\"/" configure

	if use doc; then
		myconf="--enable-html-docs --with-html-dir=/usr/share/doc/${PF}"
	else
		myconf="--disable-html-docs"
	fi

	if use jack-tmpfs; then
		myconf="${myconf} --with-default-tmpdir=/dev/shm"
	else
		myconf="${myconf} --with-default-tmpdir=/var/run/jack"
	fi

	if use userland_Darwin ; then
		append-flags -fno-common
		use altivec && append-flags -force_cpusubtype_ALL \
			-maltivec -mabi=altivec -mhard-float -mpowerpc-gfxopt
	fi

	use sndfile && \
		export SNDFILE_CFLAGS="-I/usr/include" \
		export SNDFILE_LIBS="-L/usr/$(get_libdir) -lsndfile"
	econf \
		$(use_enable altivec) \
		$(use_enable alsa) \
		$(use_enable caps capabilities) $(use_enable caps stripped-jackd) \
		$(use_enable coreaudio) \
		$(use_enable debug) \
		$(use_enable mmx) \
		$(use_enable oss) \
		$(use_enable portaudio) \
		$(use_enable sse) \
		$(use_with pic) \
		${myconf} || die "configure failed"
	emake || die "compilation failed"
}

src_install() {
	make DESTDIR=${D} datadir=${D}/usr/share install || die

	if ! use jack-tmpfs; then
		keepdir /var/run/jack
		chmod 4777 ${D}/var/run/jack
	fi

	if use doc; then
		mv ${D}/usr/share/doc/${PF}/reference/html \
		   ${D}/usr/share/doc/${PF}/

		mv ${S}/example-clients \
		   ${D}/usr/share/doc/${PF}/
	fi

	rm -rf ${D}/usr/share/doc/${PF}/reference
}
