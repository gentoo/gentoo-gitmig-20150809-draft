# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

inherit eutils flag-o-matic qt3 toolchain-funcs

MY_P=VirtualBox-OSE-${PV}
DESCRIPTION="Softwarefamily of powerful x86 virtualization"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://www.virtualbox.org/download/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 x86"
IUSE="additions alsa nowrapper sdk vboxbfe vditool"

RDEPEND="!app-emulation/virtualbox-bin
	~app-emulation/virtualbox-modules-${PV}
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
	sys-power/iasl
	alsa? ( >=media-libs/alsa-lib-1.0.13 )"
RDEPEND="${RDEPEND}
	additions? ( ~app-emulation/virtualbox-additions-${PV} )"

S=${WORKDIR}/vbox-ose-${PV}

pkg_setup() {
	# The VBoxSDL frontend needs media-libs/libsdl compiled 
	# with USE flag X enabled (bug #177335)
	if ! built_with_use media-libs/libsdl X; then
		eerror "media-libs/libsdl was compiled without the \"X\" USE flag enabled."
		eerror "Please re-emerge media-libs/libsdl with USE=\"X\"."
		die "media-libs/libsdl should be compiled with the \"X\" USE flag."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Don't build vboxdrv and additions: splitted into separate ebuilds
	epatch "${FILESDIR}/${P}-remove-splitted-stuff.patch"
	# Don't build the Alsa audio driver and remove Alsa checks in configure
	# when Alsa is not selected (bug #167739)
	use alsa || epatch "${FILESDIR}/${P}-remove-alsa.patch"
}

src_compile() {
	cd "${S}"
	./configure || die "configure failed"
	source ./env.sh

	# Force kBuild to respect C[XX]FLAGS and MAKEOPTS (bug #178529)
	# and strip all flags
	strip-flags

	MAKE="kmk" emake TOOL_GCC3_CC="$(tc-getCC)" TOOL_GCC3_CXX="$(tc-getCXX)" \
		TOOL_GCC3_AS="$(tc-getCC)" TOOL_GCC3_AR="$(tc-getAR)" \
		TOOL_GCC3_LD="$(tc-getCXX)" TOOL_GCC3_LD_SYSMOD="$(tc-getLD)" \
		TOOL_GCC3_CFLAGS="${CFLAGS}" TOOL_GCC3_CXXFLAGS="${CXXFLAGS}" \
		all || die "kmk failed"
}

src_install() {
	cd "${S}"/out/linux.${ARCH}/release/bin

	insinto /opt/VirtualBox
	if use sdk; then
		doins -r sdk
		make_wrapper xpidl "sdk/bin/xpidl" "/opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
		fperms 0755 /opt/VirtualBox/sdk/bin/xpidl
	fi
	if use vditool; then
		doins vditool
		make_wrapper vditool "./vditool" "/opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
		fperms 0755 /opt/VirtualBox/vditool
	fi
	if use vboxbfe; then
		doins VBoxBFE
		fperms 0755 /opt/VirtualBox/VBoxBFE

		if use nowrapper ; then
			make_wrapper vboxbfe "./VBoxBFE" "/opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
		else
			dosym /opt/VirtualBox/wrapper.sh /usr/bin/vboxbfe
		fi
	fi

	rm -rf sdk src tst* testcase VBoxBFE vditool xpidl SUPInstall SUPUninstall

	doins -r *
	for each in VBox{Manage,SDL,SVC,XPCOMIPCD} VirtualBox ; do
		fperms 0755 /opt/VirtualBox/${each}
	done

	if use nowrapper ; then
		make_wrapper vboxsvc "./VBoxSVC" "/opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
		make_wrapper virtualbox "./VirtualBox" "/opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
		make_wrapper vboxmanage "./VBoxManage" "/opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
		make_wrapper vboxsdl "./VBoxSDL" "/opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
	else
		exeinto /opt/VirtualBox
		newexe "${FILESDIR}/${PN}-wrapper" "wrapper.sh"
		dosym /opt/VirtualBox/wrapper.sh /usr/bin/virtualbox
		dosym /opt/VirtualBox/wrapper.sh /usr/bin/vboxmanage
		dosym /opt/VirtualBox/wrapper.sh /usr/bin/vboxsdl
	fi

	# desktop entry
	insinto /usr/share/pixmaps
	newins "${S}"/src/VBox/Frontends/VirtualBox/images/ico32x01.png ${PN}.png
	insinto /usr/share/applications
	doins "${FILESDIR}"/${PN}.desktop
}

pkg_postinst() {
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
}
