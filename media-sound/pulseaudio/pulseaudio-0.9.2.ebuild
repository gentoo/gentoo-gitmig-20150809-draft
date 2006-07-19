# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pulseaudio/pulseaudio-0.9.2.ebuild,v 1.8 2006/07/19 00:35:10 flameeyes Exp $

inherit eutils libtool autotools

DESCRIPTION="A networked sound server with an advanced plugin system"
HOMEPAGE="http://0pointer.de/lennart/projects/pulseaudio/"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="LGPL-2 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86-fbsd"

IUSE="alsa avahi caps howl jack lirc oss tcpd X"

RDEPEND="X? ( || ( x11-libs/libX11 <virtual/x11-7 ) )
	caps? ( sys-libs/libcap )
	>=media-libs/audiofile-0.2.6-r1
	>=media-libs/libsamplerate-0.1.1-r1
	>=media-libs/libsndfile-1.0.10
	>=dev-libs/liboil-0.3.6
	alsa? ( >=media-libs/alsa-lib-1.0.10 )
	>=dev-libs/glib-2.4.0
	howl? ( !avahi? ( >=net-misc/howl-0.9.8 )
		avahi? ( net-dns/avahi ) )
	>=dev-libs/liboil-0.3.0
	jack? ( >=media-sound/jack-audio-connection-kit-0.100 )
	tcpd? ( sys-apps/tcp-wrappers )
	lirc? ( app-misc/lirc )
	app-admin/eselect-esd"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if use howl && use avahi && ! built_with_use net-dns/avahi howl-compat ; then
		echo
		eerror "In order to compile polypaudio, you need to have net-dns/avahi emerged"
		eerror "with 'howl-compat' in your USE flags.  Please add that flag, re-emerge"
		eerror "avahi, and then emerge polypaudio."
		die "net-dns/avahi is missing the HOWL compatibility layer."
	fi

	enewgroup audio 18 # Just make sure it exists
	enewgroup pulse-access
	enewgroup pulse
	enewuser pulse -1 -1 /var/run/pulse pulse,audio
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-fbsd.patch"
	epatch "${FILESDIR}/${P}-moduledetect.patch"
	epatch "${FILESDIR}/${P}-esdcompat.patch"

	eautoreconf
	elibtoolize
}

src_compile() {
	local myconf

	if use howl; then
		myconf="${myconf} --enable-howl"
		if use avahi; then
			append-flags -I/usr/include/avahi-compat-howl
		fi
	fi

	econf \
		--enable-largefile \
		--enable-glib2 \
		--disable-glib1 \
		--disable-solaris \
		--disable-asyncns \
		$(use_enable oss) \
		$(use_enable alsa) \
		$(use_enable lirc) \
		$(use_enable tcpd tcpwrap) \
		$(use_enable jack) \
		$(use_enable lirc) \
		$(use_with caps) \
		$(use_with X x) \
		--disable-ltdl-install \
		--disable-dependency-tracking \
		${myconf} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	local extradepend

	emake DESTDIR="${D}" install || die "make install failed"

	newconfd "${FILESDIR}/pulseaudio.conf.d" pulseaudio

	use alsa && extradepend="$extradepend alsasound"
	sed -e "s/@extradepend@/$extradepend/" "${FILESDIR}/pulseaudio.init.d" > "${T}/pulseaudio"
	doinitd "${T}/pulseaudio"

	# This section changes the configuration files so that they are ready for
	# the system-wide pulseaudio daemon. The changes are:
	#  - use socket at /var/run/pulse/native
	#  - enable anonymous access (relies on filesystem-level access to the socket)
	#  - changes the dafault server path for the clients
	sed -e '/load-module module-native-protocol-unix/s:$: auth-anonymous=1 socket=/var/run/pulse/native:' \
		"${D}/etc/pulse/default.pa" > "${D}/etc/pulse/system.pa"
	cp "${D}"/etc/pulse/client.conf{,.system}
	sed -i -e '/default-server/d' "${D}/etc/pulse/client.conf.system"
	echo "default-server = unix:/var/run/pulse/native" >> \
		"${D}/etc/pulse/client.conf.system"

	dohtml -r doc
	dodoc README doc/todo
}

pkg_postinst() {
	elog "PulseAudio in Gentoo can use a system-wide pulseaudio daemon."
	elog "This support is enabled by starting the pulsedaemon init.d and is configured"
	elog "to read the settings from /etc/pulse/system.pa ."
	elog "To be able to use that global daemon, you need also to replace the configuration"
	elog "file /etc/pulse/client.conf with the copy in /etc/pulse/client.conf.system"
	elog "(or to put it in your ~/.pulse/client.conf)."
	elog "To be able to access that you need to be in the group pulse-access."

	eselect esd update --if-unset
}
