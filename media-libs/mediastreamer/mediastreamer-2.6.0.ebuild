# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mediastreamer/mediastreamer-2.6.0.ebuild,v 1.4 2011/01/01 20:36:35 hwoarang Exp $

EAPI="3"

inherit eutils autotools multilib

DESCRIPTION="Mediastreaming library for telephony application"
HOMEPAGE="http://www.linphone.org/index.php/eng/code_review/mediastreamer2"
SRC_URI="mirror://nongnu/linphone/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~ppc-macos ~x86-macos"
IUSE="+alsa coreaudio debug examples gsm ilbc ipv6 jack oss portaudio pulseaudio +speex theora video v4l2 x264 X"

RDEPEND=">=net-libs/ortp-0.16.2
	alsa? ( media-libs/alsa-lib )
	gsm? ( media-sound/gsm )
	jack? ( >=media-libs/libsamplerate-0.0.13
		media-sound/jack-audio-connection-kit )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.21 )
	speex? ( >=media-libs/speex-1.2_beta3 )
	video? ( media-libs/libsdl[video,X]
		media-video/ffmpeg
		theora? ( media-libs/libtheora )
		v4l2? ( media-libs/libv4l
			sys-kernel/linux-headers )
		X? ( x11-libs/libX11 ) )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

PDEPEND="ilbc? ( media-plugins/mediastreamer-ilbc )
	video? ( x264? ( media-plugins/mediastreamer-x264 ) )"

# TODO:
# run-time test for ipv6 : does it need ortp[ipv6] ?

# NOTES:
# in some way, v4l support is auto-magic but keeping it like that atm

pkg_setup() {
	if ! use oss && ! use alsa && ! use jack && ! use portaudio && ! use coreaudio;
	then
		eerror "You must enable at least oss, alsa, jack, portaudio or coreaudio"
		eerror "Please, re-emerge ${PN} with one of this USE flag enabled"
		die
	fi

	if ! use video && ( use theora || use X || use v4l2 ); then
		ewarn "X, theora and v4l2 support are enabled if video USE flag is enabled"
		ewarn "If you want X, theora or v4l support, consider re-emerge with USE=\"video\""
	fi

	if use video && ! use v4l2; then
		ewarn "Many cameras will not work or will crash your application if ${PN} is"
		ewarn "not built with v4l2 support. Please, enable USE='v4l2'."
	fi
}

src_prepare() {
	# respect user's CFLAGS
	sed -i -e "s:-O2::;s: -g::" configure.ac || die "patching configure.ac failed"

	# change default paths
	sed -i -e "s:\(\${prefix}/\)lib:\1$(get_libdir):" \
		-e "s:\(prefix/share\):\1/${PN}:" configure.ac \
		|| die "patching configure.ac failed"

	# fix html doc installation dir
	sed -i -e "s:\$(pkgdocdir):\$(docdir):" help/Makefile.am \
		|| die "patching help/Makefile.am failed"
	sed -i -e "s:\(doc_htmldir=\).*:\1\$(htmldir):" help/Makefile.am \
		|| die "patching help/Makefile.am failed"

	eautoreconf

	# don't build examples in tests/
	sed -i -e "s:\(SUBDIRS = .*\) tests \(.*\):\1 \2:" Makefile.in \
		|| die "patching Makefile.in failed"
}

src_configure() {
	local macaqsnd="--disable-macaqsnd"
	# Mac OS X Audio Queue is an audio recording facility, available on
	# 10.5 (Leopard, Darwin9) and onward
	if use coreaudio && [[ ${CHOST} == *-darwin* && ${CHOST##*-darwin} -ge 9 ]];
	then
		macaqsnd="--enable-macaqsnd"
	fi
	# strict: don't want -Werror
	# external-ortp: don't use bundled libs
	# arts: arts is deprecated
	econf \
		--htmldir="${EPREFIX}"/usr/share/doc/${PF}/html \
		--datadir="${EPREFIX}"/usr/share/${PN} \
		--libdir="${EPREFIX}"/usr/$(get_libdir) \
		--disable-strict \
		--enable-external-ortp \
		--disable-dependency-tracking \
		--disable-artsc \
		$(use_enable alsa) \
		$(use_enable pulseaudio) \
		$(use_enable coreaudio macsnd) ${macaqsnd} \
		$(use_enable debug) \
		$(use_enable gsm) \
		$(use_enable ipv6) \
		$(use_enable jack) \
		$(use_enable oss) \
		$(use_enable portaudio) \
		$(use_enable speex) \
		$(use_enable theora) \
		$(use video && use_enable v4l2 libv4l || echo --disable-libv4l) \
		$(use_enable video) \
		$(use_enable X x11)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins tests/*.c || die "doins failed"
	fi
}
