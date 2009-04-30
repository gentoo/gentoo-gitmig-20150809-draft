# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-virtualbox/xf86-video-virtualbox-2.2.2.ebuild,v 1.1 2009/04/30 16:23:20 patrick Exp $

EAPI=2

inherit x-modular eutils

MY_P=VirtualBox-${PV}-OSE
DESCRIPTION="VirtualBox video driver"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://download.virtualbox.org/virtualbox/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dri"

RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
		>=dev-util/kbuild-0.1.5-r1
		>=dev-lang/yasm-0.6.2
		sys-devel/dev86
		sys-power/iasl
		x11-proto/fontsproto
		x11-proto/randrproto
		x11-proto/renderproto
		x11-proto/xextproto
		x11-proto/xineramaproto
		x11-proto/xproto
		x11-libs/libXdmcp
		x11-libs/libXcomposite
		x11-libs/libXau
		x11-libs/libX11
		x11-libs/libXfixes
		x11-libs/libXext
	    dri? (  x11-proto/xf86driproto
				>=x11-libs/libdrm-2.4.5 )"

S=${WORKDIR}/${MY_P/-OSE/_OSE}

src_prepare() {
		# Remove shipped binaries (kBuild,yasm), see bug #232775
		rm -rf kBuild/bin tools

		# Disable things unused or splitted into separate ebuilds
		cp "${FILESDIR}/${PN}-2-localconfig" LocalConfig.kmk

		# Ugly hack to build the opengl part of the video driver
		epatch "${FILESDIR}/${PN}-2.2.0-enable-opengl.patch"
}

src_configure() {
		# build the user-space tools, warnings are harmless
		./configure --nofatal \
		--disable-xpcom \
		--disable-sdl-ttf \
		--disable-pulse \
		--disable-alsa \
		--build-headless || die "configure failed"
		source ./env.sh
}

src_compile() {
		for each in /src/VBox/{Runtime,Additions/common/VBoxGuestLib} \
		/src/VBox/{GuestHost/OpenGL,Additions/x11/x11stubs,Additions/common/crOpenGL} \
		/src/VBox/Additions/x11/vboxvideo ; do
			cd "${S}"${each}
			MAKE="kmk" emake TOOL_YASM_AS=yasm \
			KBUILD_PATH="${S}/kBuild" \
			|| die "kmk failed"
		done
}

src_install() {
		cd "${S}/out/linux.${ARCH}/release/bin/additions"
		insinto /usr/lib/xorg/modules/drivers

		# xorg-server-1.6.x (currently on the official x11 overlay)
		if has_version ">=x11-base/xorg-server-1.6" ; then
				newins vboxvideo_drv_16.so vboxvideo_drv.so
		# xorg-server-1.5.x
		elif has_version ">=x11-base/xorg-server-1.5" \
		&& has_version "<x11-base/xorg-server-1.6" ; then
				newins vboxvideo_drv_15.so vboxvideo_drv.so
		# xorg-server-1.4.x
		elif has_version ">=x11-base/xorg-server-1.4" \
		&& has_version "<x11-base/xorg-server-1.5" ; then
				newins vboxvideo_drv_14.so vboxvideo_drv.so
		# xorg-server-1.3.x
		else
				newins vboxvideo_drv_13.so vboxvideo_drv.so
		fi

		# Guest OpenGL driver
		insinto /usr/lib
		doins -r VBoxOGL* || die

		if use dri ; then
			dosym /usr/lib/VBoxOGL.so /usr/lib/dri/vboxvideo_dri.so
		fi
}

pkg_postinst() {
		elog "You need to edit the file /etc/X11/xorg.conf and set:"
		elog ""
		elog "  Driver  \"vboxvideo\""
		elog ""
		elog "in the Graphics device section (Section \"Device\")"
		elog ""
}
