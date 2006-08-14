# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-softdevice/vdr-softdevice-0.2.3.20060511-r7.ebuild,v 1.4 2006/08/14 18:51:33 zzam Exp $

inherit vdr-plugin versionator

MY_PV="$(get_version_component_range 1-3)a"
MY_P=${PN}-${MY_PV}

DESCRIPTION="VDR plugin: Software output-Device"
HOMEPAGE="http://softdevice.berlios.de/"
SRC_URI="mirror://gentoo/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="xv fbcon directfb mmx mmxext"

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
			)
			virtual/x11
		) )"

DEPEND="${RDEPEND}
	xv? ( || ( ( x11-proto/xproto
				x11-proto/xextproto
				x11-libs/libXv
			)
			virtual/x11
	) )
	fbcon? ( sys-kernel/linux-headers )"


S=${WORKDIR}/${VDRPLUGIN}-${MY_PV}
PATCHES="${FILESDIR}/${MY_P}-CVS-20060511.diff
		${FILESDIR}/vdr-softdevice-0.2.3-shm-contrast.diff
		${FILESDIR}/vdr-softdevice-0.2.3-shm-key-init.diff
		${FILESDIR}/vdr-softdevice-0.2.3-shm-fullscreen.diff
		${FILESDIR}/vdr-softdevice-0.2.3-picture-settings-use-defaults.diff"

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
			einfo "SHM does only support xv at the moment"
		fi
	else
		einfo "SHM not supported on vdr-1.2"
	fi
	case ${COMPILE_SHM} in
		0)	einfo "SHM support will not be compiled." ;;
		1)	einfo "SHM support will be compiled." ;;
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

src_unpack() {
	vdr-plugin_src_unpack

	use mmx || sed -i ${S}/Makefile -e '/MMX$/d'
	use mmxext || sed -i ${S}/Makefile -e '/MMX2$/d'

	# Do not force MMX on in configure
	sed -i ${S}/configure -e '/USE_MMX/s/^.*$/:/'
}

src_compile() {
	local MYOPTS=""
	MYOPTS="${MYOPTS} --disable-vidix"
	use xv || MYOPTS="${MYOPTS} --disable-xv"
	use fbcon || MYOPTS="${MYOPTS} --disable-fb"
	use directfb || MYOPTS="${MYOPTS} --disable-dfb"

	[[ ${COMPILE_SHM} == 1 ]] || MYOPTS="${MYOPTS} --disable-shm"

	cd ${S}
	./configure ${MYOPTS} || die "configure failed"

	vdr-plugin_src_compile
}

src_install() {
	vdr-plugin_src_install

	insinto "${VDR_PLUGIN_DIR}"
	doins libsubvdr-*.so.*

	if [[ "${COMPILE_SHM}" = "1" ]]; then
		exeinto "/usr/bin"
		doexe ShmClient
	fi
}

