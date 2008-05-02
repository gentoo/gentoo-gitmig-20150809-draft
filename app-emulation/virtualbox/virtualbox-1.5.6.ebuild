# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtualbox/virtualbox-1.5.6.ebuild,v 1.3 2008/05/02 12:55:04 nyhm Exp $

inherit eutils fdo-mime flag-o-matic qt3 toolchain-funcs

MY_P=VirtualBox-${PV}-1_OSE
DESCRIPTION="Softwarefamily of powerful x86 virtualization"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://www.virtualbox.org/download/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="additions alsa pulseaudio sdk"

RDEPEND="!app-emulation/virtualbox-bin
	>=app-emulation/virtualbox-modules-${PV}
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
	alsa? ( >=media-libs/alsa-lib-1.0.13 )
	pulseaudio? ( media-sound/pulseaudio )"
# sys-apps/hal is required at runtime (bug #197541)
RDEPEND="${RDEPEND}
	additions? ( ~app-emulation/virtualbox-additions-${PV} )
	sys-apps/usermode-utilities
	net-misc/bridge-utils
	sys-apps/hal"

S=${WORKDIR}/${MY_P/-1_/_}

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

	# Don't build things unused or splitted into separate ebuilds (eg: additions)
	epatch "${FILESDIR}/${PN}-1.5.4-remove-unused.patch"
	# Don't build the Alsa audio driver and remove Alsa checks in configure
	# when Alsa is not selected (bug #167739)
	use alsa || epatch "${FILESDIR}/${PN}-1.5.4-remove-alsa.patch"
}

src_compile() {

	local myconf
	# Don't build vboxdrv kernel module
	myconf="--disable-kmods"

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
}

src_install() {
	cd "${S}"/out/linux.${ARCH}/release/bin

	# create virtualbox configurations files
	insinto /etc/vbox
	newins "${FILESDIR}/${PN}-config" vbox.cfg
	newins "${FILESDIR}/${PN}-interfaces" interfaces

	insinto /opt/VirtualBox
	if use sdk; then
		doins -r sdk
		fowners root:vboxusers /opt/VirtualBox/sdk/bin/xpidl
		fperms 0750 /opt/VirtualBox/sdk/bin/xpidl
	fi

	rm -rf sdk src tst* testcase xpidl SUPInstall SUPUninstall VBox.png \
	VBoxBFE vditool VBoxSysInfo.sh

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

	# desktop entry
	newicon "${S}"/src/VBox/Frontends/VirtualBox/images/ico32x01.png ${PN}.png
	domenu "${FILESDIR}"/${PN}.desktop
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	elog ""
	elog "To launch VirtualBox just type: \"VirtualBox\""
	elog "You must be in the vboxusers group to use VirtualBox,"
	elog ""
	elog "The last user manual is available for download at:"
	elog "http://www.virtualbox.org/download/UserManual.pdf"
	elog ""
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
