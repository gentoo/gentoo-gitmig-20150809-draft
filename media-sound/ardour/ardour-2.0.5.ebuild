# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ardour/ardour-2.0.5.ebuild,v 1.1 2007/08/21 10:57:59 aballier Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="multi-track hard disk recording software"
HOMEPAGE="http://ardour.org/"
SRC_URI="http://ardour.org/files/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="altivec debug fftw nls sse"

RDEPEND="media-libs/liblo
	>=media-libs/liblrdf-0.4.0
	>=media-libs/raptor-1.4.2
	>=media-sound/jack-audio-connection-kit-0.101.1
	>=dev-libs/glib-2.10.3
	x11-libs/pango
	>=x11-libs/gtk+-2.8.8
	media-libs/flac
	media-libs/alsa-lib
	>=media-libs/libsamplerate-0.1.1-r1
	>=dev-libs/libxml2-2.6.0
	dev-libs/libxslt
	>=media-libs/libsndfile-1.0.16
	gnome-base/libgnomecanvas
	x11-themes/gtk-engines
	>=dev-cpp/gtkmm-2.10
	dev-cpp/glibmm
	>=dev-cpp/libgnomecanvasmm-2.10.0
	dev-cpp/cairomm
	>=dev-libs/libsigc++-2.0
	media-libs/libsoundtouch
	dev-libs/libusb
	fftw? ( =sci-libs/fftw-3* )"

DEPEND="${RDEPEND}
	sys-devel/libtool
	dev-libs/boost
	dev-util/pkgconfig
	>=dev-util/scons-0.96.1
	nls? ( sys-devel/gettext )"

pkg_setup() {
	if ! built_with_use dev-cpp/gtkmm accessibility; then
		eerror "dev-cpp/gtkmm needs to be built with use accessibility"
		eerror "in order to build ${PN}"
		die "gtkmm was not built with use accessibility"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-2.0.3-sndfile-external.patch"
	epatch "${FILESDIR}/${PN}-2.0.3-cflags.patch"
}

ardour_use_enable() {
	use ${2} && echo "${1}=1" || echo "${1}=0"
}

src_compile() {
	# Required for scons to "see" intermediate install location
	mkdir -p "${D}"

	local FPU_OPTIMIZATION=$((use altivec || use sse) && echo 1 || echo 0)
	cd "${S}"

	tc-export CC CXX

	# Avoid compiling x86 asm when building on amd64 without using sse
	# bug #186798
	use amd64 && append-flags "-DUSE_X86_64_ASM"

	scons \
		$(ardour_use_enable DEBUG debug) \
		FPU_OPTIMIZATION=${FPU_OPTIMIZATION} \
		DESTDIR="${D}" \
		$(ardour_use_enable NLS nls) \
		$(ardour_use_enable FFT_ANALYSIS fftw) \
		SYSLIBS=1 \
		CFLAGS="${CFLAGS}" \
		PREFIX=/usr || die "scons make failed"
}

src_install() {
	scons install || die "make install failed"

	dodoc DOCUMENTATION/*

	doicon "${S}/icons/icon/ardour_icon_mac.png"
	make_desktop_entry ardour2 Ardour2 ardour_icon_mac.png AudioVideo
}

pkg_postinst() {
	ewarn "---------------- WARNING -------------------"
	ewarn ""
	ewarn "Do not use Ardour 2.0 to open the only copy of sessions created with Ardour 0.99."
	ewarn "Ardour 2.0 saves the session file in a new format that Ardour 0.99 will"
	ewarn "not understand."
	ewarn ""
	ewarn "MAKE BACKUPS OF THE SESSION FILES."
	ewarn ""
	ewarn "The simplest way to address this is to make a copy of the session file itself"
	ewarn "(e.g mysession/mysession.ardour) and make that file unreadable using chmod(1)."
	ewarn ""
	ewarn "---------------- WARNING -------------------"
	ewarn ""
	ewarn "If you use KDE 3.5, be sure to uncheck 'Apply colors to non-KDE applications' in"
	ewarn "the colors configuration module if you want to be able to actually see various"
	ewarn "texts in Ardour 2."
}
