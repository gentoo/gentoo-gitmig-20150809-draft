# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtualbox/virtualbox-9999.ebuild,v 1.24 2008/01/13 21:17:29 jokey Exp $

inherit eutils fdo-mime flag-o-matic linux-mod qt3 subversion toolchain-funcs

DESCRIPTION="Softwarefamily of powerful x86 virtualization"
HOMEPAGE="http://www.virtualbox.org/"
ESVN_REPO_URI="http://virtualbox.org/svn/vbox/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="pulseaudio sdk"

RDEPEND="!app-emulation/virtualbox-bin
	!app-emulation/virtualbox-additions
	!app-emulation/virtualbox-modules
	dev-libs/libIDL
	>=dev-libs/libxslt-1.1.19
	dev-libs/xalan-c
	dev-libs/xerces-c
	media-libs/libsdl
	x11-libs/libXcursor
	x11-libs/libXt
	$(qt_min_version 3.3.5)"
DEPEND="${RDEPEND}
	sys-devel/bin86
	sys-devel/dev86
	sys-power/iasl
	>=media-libs/alsa-lib-1.0.13
	pulseaudio? ( media-sound/pulseaudio )"
# sys-apps/hal is required at runtime (bug #197541)
RDEPEND="${RDEPEND}
	sys-apps/usermode-utilities
	net-misc/bridge-utils
	sys-apps/hal"

BUILD_TARGETS="all"
MODULE_NAMES="vboxdrv(misc:${S}/out/linux.${ARCH}/release/bin/src:${S}/out/linux.${ARCH}/release/bin/src)"

pkg_setup() {
	# The VBoxSDL frontend needs media-libs/libsdl compiled
	# with USE flag X enabled (bug #177335)
	if ! built_with_use media-libs/libsdl X; then
		eerror "media-libs/libsdl was compiled without the \"X\" USE flag enabled."
		eerror "Please re-emerge media-libs/libsdl with USE=\"X\"."
		die "media-libs/libsdl should be compiled with the \"X\" USE flag."
	fi

	linux-mod_pkg_setup
	BUILD_PARAMS="KERN_DIR=${KV_DIR} KERNOUT=${KV_OUT_DIR}"

	# Add the vboxusers group before src_install
	# see (bug #184504)
	enewgroup vboxusers
}

src_compile() {

	local myconf
	if ! use pulseaudio; then
			myconf="${myconf} --disable-pulse"
	fi

	./configure \
	${myconf} || die "configure failed"
	source ./env.sh

	# Force kBuild to respect C[XX]FLAGS and MAKEOPTS (bug #178529)
	# and strip all flags
	strip-flags

	MAKE="kmk" emake TOOL_GCC3_CC="$(tc-getCC)" TOOL_GCC3_CXX="$(tc-getCXX)" \
		TOOL_GCC3_AS="$(tc-getCC)" TOOL_GCC3_AR="$(tc-getAR)" \
		TOOL_GCC3_LD="$(tc-getCXX)" TOOL_GCC3_LD_SYSMOD="$(tc-getLD)" \
		TOOL_GCC3_CFLAGS="${CFLAGS}" TOOL_GCC3_CXXFLAGS="${CXXFLAGS}" \
		all || die "kmk failed"

	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install

	cd "${S}"/out/linux.${ARCH}/release/bin
	insinto /opt/VirtualBox

	if use sdk; then
		doins -r sdk
		fowners root:vboxusers /opt/VirtualBox/sdk/bin/xpidl
		fperms 0750 /opt/VirtualBox/sdk/bin/xpidl
	fi

	rm -rf sdk src tst* testcase additions VBoxBFE vditool vboxdrv.ko xpidl SUPInstall \
	SUPUninstall VBox.png

	doins -r *
	for each in VBox{Manage,SDL,SVC,XPCOMIPCD,Tunctl} VirtualBox ; do
		fowners root:vboxusers /opt/VirtualBox/${each}
		fperms 0750 /opt/VirtualBox/${each}
	done

	exeinto /opt/VirtualBox
	newexe "${FILESDIR}/${PN}-wrapper" "VBox.sh" || die
	fowners root:vboxusers /opt/VirtualBox/VBox.sh
	fperms 0750 /opt/VirtualBox/VBox.sh
	newexe "${S}"/src/VBox/Installer/linux/VBoxAddIF.sh "VBoxAddIF.sh" || die
	fowners root:vboxusers /opt/VirtualBox/VBoxAddIF.sh
	fperms 0750 /opt/VirtualBox/VBoxAddIF.sh

	dosym /opt/VirtualBox/VBox.sh /usr/bin/VirtualBox
	dosym /opt/VirtualBox/VBox.sh /usr/bin/VBoxManage
	dosym /opt/VirtualBox/VBox.sh /usr/bin/VBoxSDL
	dosym /opt/VirtualBox/VBoxTunctl /usr/bin/VBoxTunctl
	dosym /opt/VirtualBox/VBoxAddIF.sh /usr/bin/VBoxAddIF
	dosym /opt/VirtualBox/VBoxAddIF.sh /usr/bin/VBoxDeleteIF

	# udev rule for vboxdrv
	dodir /etc/udev/rules.d
	echo 'KERNEL=="vboxdrv", GROUP="vboxusers" MODE=660' >> "${D}/etc/udev/rules.d/60-virtualbox.rules"

	# create virtualbox configurations files
	insinto /etc/vbox
	newins "${FILESDIR}/${PN}-config" vbox.cfg
	newins "${FILESDIR}/${PN}-interfaces" interfaces

	# desktop entry
	newicon "${S}"/src/VBox/Frontends/VirtualBox/images/ico32x01.png ${PN}.png
	domenu "${FILESDIR}"/${PN}.desktop
}

pkg_postinst() {
	linux-mod_pkg_postinst
	fdo-mime_desktop_database_update
	elog "To launch VirtualBox just type: \"VirtualBox\""
	elog "You must be in the vboxusers group to use VirtualBox."
	elog ""
	elog "The last user manual is available for download at:"
	elog "http://www.virtualbox.org/download/UserManual.pdf"
	elog ""
	elog "Due to the nature of the build process, there are not"
	elog "additions available for the live ebuild"
	elog ""
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
