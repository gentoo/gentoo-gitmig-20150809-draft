# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack-audio-connection-kit/jack-audio-connection-kit-0.100.7.ebuild,v 1.3 2006/01/13 11:16:59 vapier Exp $

inherit flag-o-matic eutils multilib

DESCRIPTION="A low-latency audio server"
HOMEPAGE="http://jackit.sourceforge.net/"
SRC_URI="mirror://sourceforge/jackit/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="-alpha ~amd64 ~arm -hppa -ia64 -mips ~ppc ~ppc-macos -ppc64 ~sh -sparc ~x86"
IUSE="altivec alsa caps coreaudio doc debug jack-tmpfs mmx oss portaudio sndfile sse"

RDEPEND="dev-util/pkgconfig
	sndfile? ( >=media-libs/libsndfile-1.0.0 )
	sys-libs/ncurses
	caps? ( sys-libs/libcap )
	portaudio? ( =media-libs/portaudio-18* )
	alsa? ( >=media-libs/alsa-lib-0.9.1 )
	!media-sound/jack-cvs"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

pkg_setup() {
	if ! use sndfile ; then
		ewarn "sndfile not in USE flags. jack_rec will not be installed!"
	fi

	if use caps; then
		if [[ "${KV:0:3}" == "2.4" ]]; then
			einfo "will build jackstart for 2.4 kernel"
		else
			einfo "using compatibility symlink for jackstart"
		fi
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
	#if use caps ; then
	#	epatch ${FILESDIR}/${PN}-0.99.0-jackstart.patch
	#fi

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
		--with-pic \
		${myconf} || die "configure failed"
	emake || die "compilation failed"

	if use caps && [[ "${KV:0:3}" == "2.4" ]]; then
		einfo "Building jackstart for 2.4 kernel"
		cd ${S}/jackd
		emake jackstart || die "jackstart build failed."
	fi

}

src_install() {
	make DESTDIR=${D} datadir=${D}/usr/share install || die

	if use caps; then
		if [[ "${KV:0:3}" == "2.4" ]]; then
			cd ${S}/jackd
			dobin jackstart
		else
			dosym /usr/bin/jackd /usr/bin/jackstart
		fi
	fi

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
