# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-virtualbox/xf86-input-virtualbox-4.0.12.ebuild,v 1.5 2011/10/04 19:07:17 polynomial-c Exp $

EAPI=2

inherit eutils multilib linux-info

MY_P=VirtualBox-${PV}
DESCRIPTION="VirtualBox input driver"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://download.virtualbox.org/virtualbox/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="x11-base/xorg-server
	|| ( x11-drivers/xf86-input-mouse
	    x11-drivers/xf86-input-evdev )"
DEPEND="${RDEPEND}
	=dev-util/kbuild-0.1.5*
	>=dev-lang/yasm-0.6.2
	sys-devel/dev86
	sys-power/iasl
	x11-proto/inputproto
	x11-proto/randrproto
	x11-proto/xproto"

S="${WORKDIR}/${MY_P}_OSE"

src_prepare() {
	if kernel_is -ge 2 6 33 ; then
		# evil patch for new kernels - header moved
		grep -lR linux/autoconf.h *  | xargs sed -i -e 's:<linux/autoconf.h>:<generated/autoconf.h>:' || die "Failed replacing"
	fi
	# Remove shipped binaries (kBuild,yasm), see bug #232775
	rm -rf kBuild/bin tools

	# Disable things unused or splitted into separate ebuilds
	cp "${FILESDIR}/${PN}-3-localconfig" LocalConfig.kmk
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
		/src/VBox/Additions/x11/vboxmouse ; do
			cd "${S}"${each}
			MAKE="kmk" emake TOOL_YASM_AS=yasm \
			KBUILD_PATH="${S}/kBuild" \
			|| die "kmk failed"
		done
}

src_install() {
		cd "${S}/out/linux.${ARCH}/release/bin/additions"
		insinto /usr/$(get_libdir)/xorg/modules/input

		# xorg-server-1.10
		if has_version "=x11-base/xorg-server-1.10*" ; then
				newins vboxmouse_drv_110.so vboxmouse_drv.so
		# xorg-server-1.9
		else
				newins vboxmouse_drv_19.so vboxmouse_drv.so
		fi

		cd "${S}/src/VBox/Additions/linux/installer" || die

		# install udev information file about the mouse driver
		insinto /lib/udev/rules.d
		doins 70-xorg-vboxmouse.rules

		# install X11 information file about the mouse driver
		insinto /usr/share/X11/xorg.conf.d
		doins "${S}/src/VBox/Additions/x11/Installer/50-vboxmouse.conf"
}

pkg_postinst() {
		elog "You need to edit the file /etc/X11/xorg.conf and set:"
		elog ""
		elog "	Driver  \"vboxmouse\""
		elog ""
		elog "in the Core Pointer's InputDevice section (Section \"InputDevice\")"
		elog ""
		elog "This is no longer necessary for X.Org Server 1.9 or higher. Use"
		elog "the server's udev autodetection with such versions."
}
