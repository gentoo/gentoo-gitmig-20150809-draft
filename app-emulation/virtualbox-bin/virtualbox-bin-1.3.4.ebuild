# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

inherit eutils linux-mod qt3

MY_P=VirtualBox_${PV}_Linux_x86.run

DESCRIPTION="Softwarefamily of powerful x86 virtualization"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://www.virtualbox.org/download/${PV}/${MY_P}"

LICENSE="PUEL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="additions doc"

DEPEND=">=sys-libs/glibc-2.3.5"
RDEPEND="!app-emulation/virtualbox
	amd64? (
		>=app-emulation/emul-linux-x86-baselibs-2.5.5-r3
		>=app-emulation/emul-linux-x86-qtlibs-3.4.4
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-sdl )
	x86? (
		virtual/xft
		x11-libs/libX11
		x11-libs/libXtst
		x11-libs/libXext
		x11-libs/libXt
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libXrender
		=virtual/libstdc++-3.3
		x11-libs/libXcursor
		media-libs/libsdl
		$(qt_min_version 3.3.5) )"

S=${WORKDIR}

RESTRICT="primaryuri"

BUILD_PARAMS="KERN_DIR=${KV_DIR} KERNOUT=${KV_OUT_DIR}"
BUILD_TARGETS="all"
MODULE_NAMES="vboxdrv(misc:${S}/src)"

pkg_setup() {
	linux-mod_pkg_setup
	check_license
}

src_unpack() {
	unpack_makeself ${A}
	unpack ./VirtualBox.tar.bz2
}

src_install() {
	linux-mod_src_install
	cd "${S}"

	# desktop entry
	insinto /usr/share/pixmaps
	newins VBox.png virtualbox.png
	insinto /usr/share/applications
	newins VirtualBox.desktop virtualbox.desktop
	dosed -e "10d" /usr/share/applications/virtualbox.desktop
	dosed -e "5d" /usr/share/applications/virtualbox.desktop
	dosed -e "s/VirtualBox/virtualbox/" /usr/share/applications/virtualbox.desktop
	dosed -e "s/VBox.png/virtualbox.png/" /usr/share/applications/virtualbox.desktop

	insinto /opt/VirtualBox
	doins UserManual.pdf
	if use additions; then
		doins -r additions
	fi

	rm -rf src sdk tst* UserManual.pdf rdesktop-vrdp.tar.gz deffiles install.sh routines.sh runlevel.sh \
	vboxdrv.sh VBox.png additions VirtualBox.desktop VirtualBox.tar.bz2 LICENSE

	doins -r *
	for each in VBox{Manage,SDL,SVC,XPCOMIPCD} VirtualBox ; do
		fperms 0755 /opt/VirtualBox/${each}
	done

	make_wrapper vboxsvc "./VBoxSVC" "${ROOT}opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
	make_wrapper virtualbox "./VirtualBox" "${ROOT}opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
	make_wrapper vboxmanage "./VBoxManage" "${ROOT}opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
	make_wrapper vboxsdl "./VBoxSDL" "${ROOT}opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
	make_wrapper vboxvrdp "./VBoxVRDP" "${ROOT}opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"

	# udev rule for vboxdrv
	dodir /etc/udev/rules.d
	echo 'KERNEL=="vboxdrv", GROUP="vboxusers" MODE=660' >> "${D}/etc/udev/rules.d/60-virtualbox.rules"
}

pkg_preinst() {
	enewgroup vboxusers
}

pkg_postinst() {
	if use amd64; then
		elog ""
		elog "To avoid the nmi_watchdog bug and load the vboxdrv module"
		elog "you may need to update your bootloader configuration and pass the option:"
		elog "nmi_watchdog=0"
	fi
	elog ""
	elog "In order to launch VirtualBox you need to start VBoxSVC first,"
	elog "this can be done with:"
	elog "vboxsvc --daemonize && virtualbox"
	elog ""
	elog "You must be in the vboxusers group to use VirtualBox."
	elog ""
}
