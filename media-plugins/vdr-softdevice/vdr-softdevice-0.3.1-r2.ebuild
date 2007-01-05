# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-softdevice/vdr-softdevice-0.3.1-r2.ebuild,v 1.2 2007/01/05 16:51:49 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: Software output-Device"
HOMEPAGE="http://softdevice.berlios.de/"
SRC_URI="mirror://gentoo/${P}.tgz
		http://dev.gentoo.org/~zzam/distfiles/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="xv fbcon directfb mmx mmxext xinerama"

RDEPEND=">=media-video/vdr-1.3.36
	>=media-video/ffmpeg-0.4.9_pre1
	directfb? (
		dev-libs/DirectFB
		dev-libs/DFB++
	)
	media-libs/alsa-lib
	xv? ( || ( ( x11-libs/libX11
				x11-libs/libXext
				x11-libs/libXi
				x11-libs/libXv
				xinerama? ( x11-libs/libXinerama )
			)
			virtual/x11
		) )"

DEPEND="${RDEPEND}
	xv? ( || ( ( x11-proto/xproto
				x11-proto/xextproto
				x11-libs/libXv
				xinerama? ( x11-proto/xineramaproto )
			)
			virtual/x11
	) )
	fbcon? ( sys-kernel/linux-headers )
	dev-util/pkgconfig"


PATCHES="
		${FILESDIR}/vdr-softdevice-0.2.3-shm-fullscreen.diff
		${FILESDIR}/softdevice-cvs-xinerama-configure-opts.patch
		${FILESDIR}/vdr-softdevice-0.3.1-osdmode-software-default.diff"

pkg_setup() {
	vdr-plugin_pkg_setup

	if use !xv && use !fbcon && use !directfb; then
		ewarn "You need to set at least one of these use-flags: xv fbcon directfb"
		die "no output-method enabled"
	fi

	COMPILE_SHM=0
	if has_version ">=media-video/vdr-1.3.0"; then
		if use xv; then
			COMPILE_SHM=1
		else
			elog "SHM does only support xv at the moment"
		fi
	else
		elog "SHM not supported on vdr-1.2"
	fi
	case ${COMPILE_SHM} in
		0)	elog "SHM support will not be compiled." ;;
		1)	elog "SHM support will be compiled." ;;
	esac

	# Check for ffmpeg relying on libtheora without pkg-config-file
	# Bug #142250
	if built_with_use media-video/ffmpeg theora	&& \
		has_version "<media-libs/libtheora/libtheora-1.0_alpha4"; then

			eerror "This package will not work when using ffmpeg with"
			eerror "USE=\"theora\" combined with media-libs/libtheora"
			eerror "older than version 1.0_alpha4."
			eerror "Please update to at least media-libs/libtheora-1.0_alpha4."
			die "Please update to at least media-libs/libtheora-1.0_alpha4."
	fi
}

src_compile() {
	local MYOPTS=""
	MYOPTS="${MYOPTS} --disable-vidix"
	use xv || MYOPTS="${MYOPTS} --disable-xv"
	use fbcon || MYOPTS="${MYOPTS} --disable-fb"
	use directfb || MYOPTS="${MYOPTS} --disable-dfb"

	# MMX-Support
	# hardcode mmx for amd64 - do not disable even without use-flag
	if ! use amd64; then
		use mmx || MYOPTS="${MYOPTS} --disable-mmx"
		use mmxext || MYOPTS="${MYOPTS} --disable-mmx2"

		if use !mmx && use !mmxext; then
			ewarn "${PN}"' does not compile with USE="-mmx -mmxext".'
			ewarn 'Please enable at least one of these two use-flags.'
			die "${PN}"' does not compile with USE="-mmx -mmxext".'
		fi
	fi

	use xinerama || MYOPTS="${MYOPTS} --disable-xinerama"

	[[ ${COMPILE_SHM} == 1 ]] || MYOPTS="${MYOPTS} --disable-shm"

	cd ${S}
	elog configure ${MYOPTS}
	./configure ${MYOPTS} || die "configure failed"

	vdr-plugin_src_compile
}

src_install() {
	vdr-plugin_src_install

	cd ${S}

	insinto "${VDR_PLUGIN_DIR}"
	doins libsoftdevice-*.so.*

	if [[ "${COMPILE_SHM}" = "1" ]]; then
		exeinto "/usr/bin"
		doexe ShmClient
	fi

	insinto /usr/include/vdr-softdevice
	doins *.h
}

