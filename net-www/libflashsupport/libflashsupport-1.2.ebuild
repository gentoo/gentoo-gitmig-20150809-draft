# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/libflashsupport/libflashsupport-1.2.ebuild,v 1.2 2008/04/26 23:30:28 lack Exp $

inherit multilib

DESCRIPTION="Adds pulseaudio/esd/oss audio output and HTTPS/RTMPS support to
Adobe Flash 9"
HOMEPAGE="http://pulseaudio.revolutionlinux.com/PulseAudio"
SRC_URI="https://svn.revolutionlinux.com/MILLE/XTERM/trunk/libflashsupport/Tarballs/${P}.tar.bz2"

LICENSE="Adobe-SourceCode"
SLOT="0"
KEYWORDS="~x86"

# Note: gnutls overrides 'ssl' if both are set.  If only 'ssl' is set, openssl
# is used.
IUSE="pulseaudio esd oss ssl gnutls"

DEPEND="gnutls? ( net-libs/gnutls )
	!gnutls? ( ssl? ( dev-libs/openssl ) )"

RDEPEND="${DEPEND}
	pulseaudio? ( media-sound/pulseaudio )
	esd? ( media-sound/esound )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:/var/lib/run/pulse/native:/var/run/pulse/native:' \
		README flashsupport.c || die "sed failed"
}

src_compile() {
	if use pulseaudio; then
		export LIBPULSEPATH="-DLIBPULSEPATH='\"libpulse-simple.so.0\"'"
		export PULSE="-DPULSEAUDIO"
	else
		export LIBPULSEPATH=""
		export PULSE=""
	fi

	if use esd; then
		export LIBESDPATH="-DLIBESDPATH='\"libesd.so.0\"'"
		export ESD="-DESD"
	else
		export LIBESDPATH=""
		export ESD=""
	fi

	if use oss; then
		export OSS="-DOSS"
	else
		export OSS=""
	fi

	if use gnutls; then
		if use ssl; then
			ewarn "You have enabled both 'ssl' and 'gnutls', so we will use"
			ewarn "gnutls and not openssl for HTTPS/RTMPS support"
		fi
		export SSL="-DGNUTLS"
		export SSLLIBS="-lgnutls"
	elif use ssl; then
		export SSL="-DOPENSSL"
		export SSLLIBS="-lssl"
	else
		export SSL=""
		export SSLLIBS=""
	fi

	# Force internal alsa
	export ALSA="-DALSA_INTERNAL"
	export ALSALIBS=""

	# ICU and V4L support is commented out in the makefile, ensure it is off.
	export ICULIBS=""
	export V4L=""

	# General overrides
	export CFLAGS="${CFLAGS} -fPIC -shared"
	export LIBDIR="/usr/$(get_libdir)"

	# Override Makefile options with environment exported above:
	emake -e || die "Make failed"
}

src_install() {
	dolib.so libflashsupport.so
	dodoc README
}
