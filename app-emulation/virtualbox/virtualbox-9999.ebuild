# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtualbox/virtualbox-9999.ebuild,v 1.18 2007/09/04 23:56:09 jokey Exp $

inherit eutils flag-o-matic linux-mod qt3 subversion toolchain-funcs

DESCRIPTION="Softwarefamily of powerful x86 virtualization"
HOMEPAGE="http://www.virtualbox.org/"
ESVN_REPO_URI="http://virtualbox.org/svn/vbox/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="hal nowrapper sdk vboxbfe vditool"

RDEPEND="!app-emulation/virtualbox-bin
	dev-libs/libIDL
	>=dev-libs/libxslt-1.1.19
	dev-libs/xalan-c
	dev-libs/xerces-c
	media-libs/libsdl
	x11-libs/libXcursor
	$(qt_min_version 3.3.5)
	hal? ( sys-apps/hal )"
DEPEND="${RDEPEND}
	sys-devel/bin86
	sys-devel/dev86
	sys-power/iasl
	>=media-libs/alsa-lib-1.0.13"

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
	cd "${S}"

	local myconf
	if ! use hal; then
		myconf="${myconf} --without-hal"
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
		make_wrapper xpidl "sdk/bin/xpidl" "/opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
		fowners root:vboxusers /opt/VirtualBox/sdk/bin/xpidl
		fperms 0750 /opt/VirtualBox/sdk/bin/xpidl
	fi
	if use vboxbfe; then
		doins VBoxBFE
		fowners root:vboxusers /opt/VirtualBox/VBoxBFE
		fperms 0750 /opt/VirtualBox/VBoxBFE

		if use nowrapper ; then
			make_wrapper vboxbfe "./VBoxBFE" "/opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
		else
			dosym /opt/VirtualBox/wrapper.sh /usr/bin/vboxbfe
		fi
	fi

	rm -rf sdk src tst* testcase additions VBoxBFE vditool vboxdrv.ko xpidl SUPInstall SUPUninstall

	doins -r *
	for each in VBox{Manage,SDL,SVC,XPCOMIPCD} VirtualBox ; do
		fowners root:vboxusers /opt/VirtualBox/${each}
		fperms 0750 /opt/VirtualBox/${each}
	done

	if use nowrapper ; then
		make_wrapper vboxsvc "./VBoxSVC" "/opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
		make_wrapper virtualbox "./VirtualBox" "/opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
		make_wrapper vboxmanage "./VBoxManage" "/opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
		make_wrapper vboxsdl "./VBoxSDL" "/opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
	else
		exeinto /opt/VirtualBox
		newexe "${FILESDIR}/${PN}-wrapper" "wrapper.sh"
		fowners root:vboxusers /opt/VirtualBox/wrapper.sh
		fperms 0750 /opt/VirtualBox/wrapper.sh

		dosym /opt/VirtualBox/wrapper.sh /usr/bin/virtualbox
		dosym /opt/VirtualBox/wrapper.sh /usr/bin/vboxmanage
		dosym /opt/VirtualBox/wrapper.sh /usr/bin/vboxsdl
	fi

	# udev rule for vboxdrv
	dodir /etc/udev/rules.d
	echo 'KERNEL=="vboxdrv", GROUP="vboxusers" MODE=660' >> "${D}/etc/udev/rules.d/60-virtualbox.rules"

	# desktop entry
	insinto /usr/share/pixmaps
	newins "${S}"/src/VBox/Frontends/VirtualBox/images/ico32x01.png ${PN}.png
	insinto /usr/share/applications
	doins "${FILESDIR}"/${PN}.desktop
	dosed -e "s/Version=/Version=${PV}/" /usr/share/applications/${PN}.desktop
}

pkg_postinst() {
	linux-mod_pkg_postinst
	if use amd64; then
		elog ""
		elog "To avoid the nmi_watchdog bug and load the vboxdrv module"
		elog "you may need to update your bootloader configuration and pass the option:"
		elog "nmi_watchdog=0"
	fi
	elog ""
	if use nowrapper; then
		elog "In order to launch VirtualBox you need to start the"
		elog "VirtualBox XPCom Server first, with:"
		elog "vboxsvc --daemonize && virtualbox"
	else
		elog "To launch VirtualBox just type: \"virtualbox\""
	fi
	elog ""
	elog "You must be in the vboxusers group to use VirtualBox."
	elog ""
	elog "The last user manual is available for download at:"
	elog "http://www.virtualbox.org/download/UserManual.pdf"
	elog ""
	elog "Due to the nature of the build process, there are not"
	elog "additions available for the live ebuild"
	elog ""
}
