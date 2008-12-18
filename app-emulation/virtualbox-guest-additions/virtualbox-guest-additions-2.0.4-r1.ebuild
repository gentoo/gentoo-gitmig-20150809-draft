# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtualbox-guest-additions/virtualbox-guest-additions-2.0.4-r1.ebuild,v 1.1 2008/12/18 12:14:53 flameeyes Exp $

inherit eutils linux-mod

MY_P=VirtualBox-${PV}-OSE
DESCRIPTION="VirtualBox kernel modules and user-space tools for Linux guests"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://download.virtualbox.org/virtualbox/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

RDEPEND="x11-libs/libXt
		amd64? ( app-emulation/emul-linux-x86-xlibs )
		X? ( ~x11-drivers/xf86-video-virtualbox-${PV}
			 ~x11-drivers/xf86-input-virtualbox-${PV}
			 x11-apps/xrandr
			 x11-apps/xrefresh
			 x11-libs/libXmu )"
DEPEND="${RDEPEND}
		>=dev-util/kbuild-0.1.4
		>=dev-lang/yasm-0.6.2
		sys-devel/bin86
		sys-devel/dev86
		sys-power/iasl
		x11-proto/renderproto"

BUILD_TARGETS="all"
BUILD_TARGET_ARCH="${ARCH}"
MODULE_NAMES="vboxadd(misc:${WORKDIR}/vboxadd:${WORKDIR}/vboxadd)
			vboxvfs(misc:${WORKDIR}/vboxvfs:${WORKDIR}/vboxvfs)"

S=${WORKDIR}/${MY_P/-OSE/}

pkg_setup() {
		linux-mod_pkg_setup
		BUILD_PARAMS="KERN_DIR=${KV_DIR} KERNOUT=${KV_OUT_DIR}"
}

src_unpack() {
		unpack ${A}

		# Create and unpack a tarball with the sources of the Linux guest
		# kernel modules, to include all the needed files
		"${MY_P/-OSE/}"/src/VBox/Additions/linux/export_modules "${WORKDIR}/vbox-kmod.tar.gz"
		unpack ./vbox-kmod.tar.gz

		# Remove shipped binaries (kBuild,yasm), see bug #232775
		cd "${S}"
		rm -rf kBuild/bin tools

		# Disable things unused or splitted into separate ebuilds
		cp "${FILESDIR}/${PN}-2-localconfig" LocalConfig.kmk
}

src_compile() {
		linux-mod_src_compile

		# build the user-space tools, warnings are harmless
		./configure --nofatal \
		--disable-xpcom \
		--disable-sdl-ttf \
		--disable-pulse \
		--disable-alsa \
		--build-headless || die "configure failed"
		source ./env.sh

		for each in	/src/VBox/{Runtime,Additions/common} \
		/src/VBox/Additions/linux/{sharedfolders,daemon} ; do
				cd "${S}"${each}
				MAKE="kmk" emake TOOL_YASM_AS=yasm \
				KBUILD_PATH="${S}/kBuild" \
				|| die "kmk VBoxControl failed"
		done

		if use X; then
				cd "${S}"/src/VBox/Additions/x11/xclient
				MAKE="kmk" emake TOOL_YASM_AS=yasm \
				KBUILD_PATH="${S}/kBuild" \
				|| die "kmk VBoxClient failed"
		fi
}

src_install() {
		linux-mod_src_install

		cd "${S}"/out/linux.${ARCH}/release/bin/additions

		# shared folders
		insinto /sbin
		newins mountvboxsf mount.vboxsf
		fperms 4755 /sbin/mount.vboxsf

		# time synchronisation system service
		insinto /usr/sbin
		doins vboxadd-timesync
		fperms 0755 /usr/sbin/vboxadd-timesync

		newinitd "${FILESDIR}"/${PN}.initd ${PN}

		insinto /usr/bin
		doins VBoxControl
		fperms 4755 /usr/bin/VBoxControl

		# VBoxClient user service and xrandr wrapper
		if use X; then
			doins VBoxClient
			fperms 4755 /usr/bin/VBoxClient

			dodir /etc/X11/xinit/xinitrc.d/
			echo -e "#/bin/sh\n/usr/bin/VBoxClient" \
			>> "${D}/etc/X11/xinit/xinitrc.d/98VBoxClient"
			fperms 0755 /etc/X11/xinit/xinitrc.d/98VBoxClient

			cd "${S}"/src/VBox/Additions/x11/installer
			newins VBoxRandR.sh VBoxRandR
			fperms 0755 /usr/bin/VBoxRandR
		fi

		# udev rule for vboxdrv
		dodir /etc/udev/rules.d
		echo 'KERNEL=="vboxadd", NAME="vboxadd", OWNER="root", MODE="0660"' \
		>> "${D}/etc/udev/rules.d/60-virtualbox-guest-additions.rules"
}

pkg_postinst() {
		linux-mod_pkg_postinst
		if ! useq X ; then
			elog "use flag X is off, enable it to install the"
			elog "X Window System input and video drivers"
		fi
		elog "Please add:"
		elog "/etc/init.d/${PN}"
		elog "to the default runlevel in order to load all"
		elog "needed modules and services."
		elog ""
		elog "Warning:"
		elog "this ebuild is only needed if you are running gentoo"
		elog "inside a VirtualBox Virtual Machine, you don't need"
		elog "it to run VirtualBox itself."
		elog ""
}
