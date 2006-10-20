# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pulseaudio/pulseaudio-0.9.5-r4.ebuild,v 1.5 2006/10/20 20:00:12 gustavoz Exp $

inherit eutils libtool # autotools

DESCRIPTION="A networked sound server with an advanced plugin system"
HOMEPAGE="http://0pointer.de/lennart/projects/pulseaudio/"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="LGPL-2 GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh sparc ~x86 ~x86-fbsd"
IUSE="alsa avahi caps jack lirc oss tcpd X hal"

RDEPEND="X? ( || ( x11-libs/libX11 <virtual/x11-7 ) )
	caps? ( sys-libs/libcap )
	>=media-libs/audiofile-0.2.6-r1
	>=media-libs/libsamplerate-0.1.1-r1
	>=media-libs/libsndfile-1.0.10
	>=dev-libs/liboil-0.3.6
	alsa? ( >=media-libs/alsa-lib-1.0.10 )
	>=dev-libs/glib-2.4.0
	avahi? ( >=net-dns/avahi-0.6.12 )
	>=dev-libs/liboil-0.3.0
	jack? ( >=media-sound/jack-audio-connection-kit-0.100 )
	tcpd? ( sys-apps/tcp-wrappers )
	lirc? ( app-misc/lirc )
	hal? ( >=sys-apps/hal-0.5.7 )
	app-admin/eselect-esd
	sys-devel/libtool" # it's a valid RDEPEND, libltdl.so is used
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if use avahi && ! built_with_use net-dns/avahi dbus ; then
		echo
		eerror "In order to compile pulseaudio with avahi support, you need to have"
		eerror "net-dns/avahi emerged with 'dbus' in your USE flag. Please add that"
		eerror "flag, re-emerge avahi, and then emerge pulseaudio again."
		die "net-dns/avahi is missing the D-Bus bindings."
	fi

	enewgroup audio 18 # Just make sure it exists
	enewgroup pulse-access
	enewgroup pulse-rt
	enewgroup pulse
	enewuser pulse -1 -1 /var/run/pulse pulse,audio
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-esdcompat.patch"
	epatch "${FILESDIR}/${P}-fbsd.patch"
	epatch "${FILESDIR}/${P}-noshm.patch"

	# eautoreconf
	elibtoolize
}

src_compile() {
	econf \
		--enable-largefile \
		--enable-glib2 \
		--disable-solaris \
		--disable-asyncns \
		$(use_enable oss) \
		$(use_enable alsa) \
		$(use_enable lirc) \
		$(use_enable tcpd tcpwrap) \
		$(use_enable jack) \
		$(use_enable lirc) \
		$(use_enable avahi) \
		$(use_enable hal) \
		$(use_with caps) \
		$(use_with X x) \
		--disable-ltdl-install \
		--localstatedir=/var \
		--with-realtime-group=pulse-rt \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "make install failed"

	newconfd "${FILESDIR}/pulseaudio.conf.d" pulseaudio

	local neededservices
	use alsa && neededservices="$neededservices alsasound"
	use avahi && neededservices="$neededservices avahi-daemon"
	use hal && neededservices="$neededservices hald"
	[[ -n ${neededservices} ]] && sed -e "s/@neededservices@/need $neededservices/" "${FILESDIR}/pulseaudio.init.d-2" > "${T}/pulseaudio"
	doinitd "${T}/pulseaudio"

	if ! use hal; then
		sed -i -e '/module-hal-detect/s:^:#: ; /module-detect/s:^#::' "${D}/etc/pulse/default.pa"
	fi
	use avahi && sed -i -e '/module-zeroconf-publish/s:^#::' "${D}/etc/pulse/default.pa"

	dohtml -r doc
	dodoc README

	# Create the state directory
	diropts -o pulse -g pulse -m0755
	keepdir /var/run/pulse
}

pkg_postinst() {
	elog "PulseAudio in Gentoo can use a system-wide pulseaudio daemon."
	elog "This support is enabled by starting the pulsedaemon init.d ."
	elog "To be able to access that you need to be in the group pulse-access."
	elog "For more information about system-wide support, please refer to"
	elog "	 http://pulseaudio.org/wiki/SystemWideInstance"

	elog "To use the ESounD wrapper while using a system-wide daemon, you also"
	elog "need to enable auth-anonymous for the esound-unix module, or to copy"
	elog "/var/run/pulse/.esd_auth into each home directory."

	eselect esd update --if-unset
}
