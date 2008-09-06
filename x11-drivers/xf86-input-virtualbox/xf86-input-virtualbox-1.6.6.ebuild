# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-virtualbox/xf86-input-virtualbox-1.6.6.ebuild,v 1.1 2008/09/06 19:27:14 jokey Exp $

inherit x-modular eutils

MY_P=VirtualBox-${PV}-OSE
DESCRIPTION="VirtualBox input driver"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://download.virtualbox.org/virtualbox/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
		dev-util/kbuild
		>=dev-lang/yasm-0.6.2
		sys-devel/dev86
		sys-power/iasl
		x11-proto/inputproto
		x11-proto/randrproto
		x11-proto/xproto"

S=${WORKDIR}/${MY_P/-OSE/}

src_unpack() {
		unpack ${A}
		cd "${S}"

		# Remove shipped binaries (kBuild,yasm), see bug #232775
		rm -rf kBuild/bin tools
}

src_compile() {
		# build the user-space tools, warnings are harmless
		./configure --nofatal \
		--disable-xpcom \
		--disable-sdl-ttf \
		--disable-pulse \
		--disable-alsa \
		--build-headless || die "configure failed"
		source ./env.sh

		for each in src/VBox/{Runtime,Additions/common/VBoxGuestLib} \
		src/VBox/Additions/x11/xmouse ; do
			MAKE="kmk" emake TOOL_YASM_AS=yasm \
			|| die "kmk failed"
		done
}

src_install() {
		cd "${S}/out/linux.${ARCH}/release/bin/additions"
		insinto /usr/lib/xorg/modules/input

		if has_version "<x11-base/xorg-server-1.4" ; then
				newins vboxmouse_drv_71.so vboxmouse_drv.so
		else
				newins vboxmouse_drv_14.so vboxmouse_drv.so
		fi
}

pkg_postinst() {
		elog "You need to edit the file /etc/X11/xorg.conf and set:"
		elog ""
		elog "	Driver  \"vboxmouse\""
		elog ""
		elog "in the Core Pointer's InputDevice section (Section \"InputDevice\")"
		elog ""
}
