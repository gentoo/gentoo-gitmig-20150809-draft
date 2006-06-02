# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-softdevice/vdr-softdevice-0.2.3.20060511-r5.ebuild,v 1.1 2006/06/02 12:18:54 zzam Exp $

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
			)
			virtual/x11
	) )
	fbcon? ( sys-kernel/linux-headers )"


S=${WORKDIR}/${VDRPLUGIN}-${MY_PV}
PATCHES="${FILESDIR}/${MY_P}-Makefile.diff ${FILESDIR}/${MY_P}-CVS-20060511.diff
		${FILESDIR}/vdr-softdevice-0.2.3-shm-contrast.diff
		${FILESDIR}/vdr-softdevice-0.2.3-shm-key-init.diff
		${FILESDIR}/vdr-softdevice-0.2.3-shm-fullscreen.diff"

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
}

disable_in_makefile() {
	local makefile_define="${1}"
	sed -i Makefile -e "s-^${makefile_define}-#${makefile_define}-"
}

src_unpack() {
	vdr-plugin_src_unpack

	cd ${S}
	disable_in_makefile VIDIX_SUPPORT
	use xv || disable_in_makefile XV_SUPPORT
	use directfb || disable_in_makefile DFB_SUPPORT
	use fbcon || disable_in_makefile FB_SUPPORT
	if [[ "${COMPILE_SHM}" = "1" ]]; then
		sed -i Makefile -e 's:^#SHM_SUPPORT:SHM_SUPPORT:'
	fi

	use mmxext || sed -i Makefile -e '/MMX2$/d'
	use mmx || sed -i Makefile -e '/MMX$/d'
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

