# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

inherit eutils linux-mod qt3 subversion

DESCRIPTION="Softwarefamily of powerful x86 virtualization"
HOMEPAGE="http://www.virtualbox.org/"
ESVN_REPO_URI="http://virtualbox.org/svn/vbox/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="additions sdk"

RDEPEND="!app-emulation/virtualbox-bin
	dev-libs/libIDL
	>=dev-libs/libxslt-1.1.19
	dev-libs/xalan-c
	dev-libs/xerces-c
	media-libs/libsdl
	x11-libs/libXcursor
	$(qt_min_version 3.3.5)
	=virtual/libstdc++-3.3"
DEPEND="${RDEPEND}
	sys-devel/bin86
	sys-devel/dev86
	sys-power/iasl"
RDEPEND="${RDEPEND}
	additions? ( =app-emulation/virtualbox-additions-1.3.4 )"

BUILD_PARAMS="KERN_DIR=${KV_DIR} KERNOUT=${KV_OUT_DIR}"
BUILD_TARGETS="all"
MODULE_NAMES="vboxdrv(misc:${S}/out/linux.${ARCH}/release/bin/src:${S}/out/linux.${ARCH}/release/bin/src)"

src_compile() {
	cd "${S}"
	./configure || die "configure failed"
	source ./env.sh
	kmk all || die "kmk failed"
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install

	cd "${S}"/out/linux.${ARCH}/release/bin

	insinto /opt/VirtualBox
	if use sdk; then
	    doins -r sdk
	    make_wrapper xpidl "sdk/bin/xpidl" "${ROOT}opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
	    fperms 0755 /opt/VirtualBox/sdk/bin/xpidl
	fi

	rm -rf sdk src tst* testcase additions vboxdrv.ko SUPInstall SUPUninstall

	doins -r *
	for each in VBox{BFE,Manage,SDL,SVC,XPCOMIPCD} VirtualBox vditool xpidl ; do
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

	# desktop entry
	insinto /usr/share/pixmaps
	newins "${S}"/src/VBox/Frontends/VirtualBox/images/ico32x01.png ${PN}.png
	insinto /usr/share/applications
	doins "${FILESDIR}"/${PN}.desktop
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
	elog "The last user manual is available for download at:"
	elog "http://www.virtualbox.org/download/UserManual.pdf"
	elog ""
}
