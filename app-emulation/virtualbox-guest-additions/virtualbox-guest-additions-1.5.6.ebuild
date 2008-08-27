# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtualbox-guest-additions/virtualbox-guest-additions-1.5.6.ebuild,v 1.2 2008/08/27 12:30:59 jokey Exp $

inherit eutils linux-mod

MY_P=VirtualBox-${PV}-1_OSE
DESCRIPTION="VirtualBox kernel modules and user-space tools for Linux guests"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://www.virtualbox.org/download/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

RDEPEND="x11-libs/libXt
		amd64? ( app-emulation/emul-linux-x86-xlibs )
		X? ( ~x11-drivers/xf86-video-virtualbox-${PV}
			 ~x11-drivers/xf86-input-virtualbox-${PV} )"
DEPEND="${RDEPEND}
		sys-devel/bin86
		sys-devel/dev86
		sys-power/iasl
		x11-proto/renderproto"

BUILD_TARGETS="all"
BUILD_TARGET_ARCH="${ARCH}"
MODULE_NAMES="vboxadd(misc:${WORKDIR}/vboxadd:${WORKDIR}/vboxadd)
			vboxvfs(misc:${WORKDIR}/vboxvfs:${WORKDIR}/vboxvfs)"

S=${WORKDIR}/${MY_P/-1_/_}

pkg_setup() {
		linux-mod_pkg_setup
		BUILD_PARAMS="KERN_DIR=${KV_DIR} KERNOUT=${KV_OUT_DIR}"
}

src_unpack() {
		unpack ${A}

		# Create and unpack a tarball with the sources of the Linux guest
		# kernel modules, to include all the needed files
		"${MY_P/-1_/_}"/src/VBox/Additions/linux/export_modules "${WORKDIR}/vbox-kmod.tar.gz"
		unpack ./vbox-kmod.tar.gz

		# Disable (unused) alsa checks in {configure, Comfig.kmk}
		epatch "${FILESDIR}/${P}-remove-alsa.patch"
}

src_compile() {
		linux-mod_src_compile

		# build the user-space tools, warnings are harmless
		./configure --nofatal \
		--disable-xpcom \
		--disable-sdl-ttf \
		--disable-pulse \
		--build-headless || die "configure failed"
		source ./env.sh

		for each in	src/VBox/{Runtime,Additions/common} \
		src/VBox/Additions/linux{sharefolders,daemon,xclient} ; do
				MAKE="kmk" emake || die "kmk failed"
		done
}

src_install() {
		linux-mod_src_install

		cd "${S}"/out/linux.${ARCH}/release/bin/additions

		# shared folders
		insinto /sbin
		newins mountvboxsf mount.vboxvfs
		fperms 4755 /sbin/mount.vboxvfs

		# time synchronisation system service
		insinto /usr/sbin
		doins vboxadd-timesync
		fperms 0755 /usr/sbin/vboxadd-timesync

		# shared clipboard user service
		insinto /usr/bin
		doins vboxadd-xclient
		fperms 4755 /usr/bin/vboxadd-xclient

		newinitd "${FILESDIR}"/${P}.initd ${PN}

		# shared clipboard user service xinit script
		if use X; then
			dodir /etc/X11/xinit/xinitrc.d/
			echo -e "#/bin/sh\n/usr/bin/vboxadd-xclient" \
			>> "${D}/etc/X11/xinit/xinitrc.d/98vboxadd-xclient"
			fperms 0755 /etc/X11/xinit/xinitrc.d/98vboxadd-xclient
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
		elog ""
		elog "Warning:"
		elog "this ebuild is only needed if you are running gentoo"
		elog "inside a VirtualBox Virtual Machine, you don't need"
		elog "it to run VirtualBox itself"
		elog ""
}
