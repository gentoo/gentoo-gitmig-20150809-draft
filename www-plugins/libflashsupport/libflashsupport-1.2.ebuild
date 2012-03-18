# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/libflashsupport/libflashsupport-1.2.ebuild,v 1.6 2012/03/18 13:36:54 ssuominen Exp $

EAPI="3"
inherit eutils multilib toolchain-funcs

DESCRIPTION="Adds pulseaudio/oss audio output and HTTPS/RTMPS support to Adobe Flash 9"
HOMEPAGE="http://pulseaudio.org/wiki/FlashPlayer9Solution"
SRC_URI="https://svn.revolutionlinux.com/MILLE/XTERM/trunk/libflashsupport/Tarballs/${P}.tar.bz2"

LICENSE="Adobe-SourceCode"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# Note: gnutls overrides 'ssl' if both are set.  If only 'ssl' is set, openssl
# is used.
IUSE="pulseaudio oss ssl gnutls"

DEPEND="gnutls? ( net-libs/gnutls )
	!gnutls? ( ssl? ( dev-libs/openssl ) )
	pulseaudio? ( media-sound/pulseaudio )"

RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's:/var/lib/run/pulse/native:/var/run/pulse/native:' \
		README flashsupport.c || die "sed failed"

	epatch "${FILESDIR}"/${P}-asneeded.patch
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_compile() {
	tc-export CC
	if use pulseaudio; then
		export LIBPULSEPATH="-DLIBPULSEPATH='\"libpulse-simple.so.0\"'"
		export PULSE="-DPULSEAUDIO"
	else
		export LIBPULSEPATH=""
		export PULSE=""
	fi

	# There is no media-sound/esound in tree anymore
	export LIBESDPATH=""
	export ESD=""

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

pkg_postinst() {
	if has_version ">=www-plugins/adobe-flash-10" && use pulseaudio; then
		ewarn "You do not need libflashsupport to use adobe-flash with pulseaudio"
		ewarn "Please consider removing this package and using"
		ewarn "media-plugins/alsa-plugins[pulseaudio] instead."
	fi

	if use amd64 && has_version ">=www-plugins/adobe-flash-10[32bit]"; then
		ewarn "The 32-bit flash plugin cannot use libflashsupport which is 64-bit only."
	fi
}
