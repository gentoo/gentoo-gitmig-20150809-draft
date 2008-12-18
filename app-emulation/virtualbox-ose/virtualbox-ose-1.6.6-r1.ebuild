# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtualbox-ose/virtualbox-ose-1.6.6-r1.ebuild,v 1.1 2008/12/18 12:47:58 flameeyes Exp $

EAPI=1

inherit eutils fdo-mime flag-o-matic qt3 toolchain-funcs

MY_P=VirtualBox-${PV}-OSE
DESCRIPTION="Softwarefamily of powerful x86 virtualization"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://download.virtualbox.org/virtualbox/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="additions alsa headless pulseaudio +qt3 sdk"

RDEPEND="!app-emulation/virtualbox-bin
	~app-emulation/virtualbox-modules-${PV}
	dev-libs/libIDL
	>=dev-libs/libxslt-1.1.19
	!headless? (
		qt3? ( x11-libs/qt:3 )
		x11-libs/libXcursor
		media-libs/libsdl
		x11-libs/libXt )"
DEPEND="${RDEPEND}
	dev-util/kbuild
	>=dev-lang/yasm-0.6.2
	sys-devel/bin86
	sys-devel/dev86
	sys-power/iasl
	media-libs/libpng
	alsa? ( >=media-libs/alsa-lib-1.0.13 )
	pulseaudio? ( media-sound/pulseaudio )"
# sys-apps/hal is required at runtime (bug #197541)
RDEPEND="${RDEPEND}
	additions? ( ~app-emulation/virtualbox-ose-additions-${PV} )
	sys-apps/usermode-utilities
	net-misc/bridge-utils
	sys-apps/hal"

S=${WORKDIR}/${MY_P/-OSE/}

pkg_setup() {
	# known problems with gcc 4.3 and the recompiler
	# http://www.virtualbox.org/ticket/936
	if [[ "$(gcc-major-version)$(gcc-minor-version)" == "43" ]]; then
			eerror "there are known problems with gcc 4.3 and the virtualbox"
			eerror "recompiler stuff. Please use at least a version of gcc < 4.3"
			die "gcc 4.3 cannot build the virtualbox recompiler"
	fi

	if ! use headless; then
			# The VBoxSDL frontend needs media-libs/libsdl compiled
			# with USE flag X enabled (bug #177335)
			if ! built_with_use media-libs/libsdl X; then
				eerror "media-libs/libsdl was compiled without the \"X\" USE flag enabled."
				eerror "Please re-emerge media-libs/libsdl with USE=\"X\"."
				die "media-libs/libsdl should be compiled with the \"X\" USE flag."
			fi
			if ! use qt3; then
					einfo ""
					einfo "No USE=\"qt3\" selected, this build will not include"
					einfo "any Qt frontend."
					einfo ""
			fi
	else
			if use qt3; then
					einfo ""
					einfo "You selected USE=\"qt3 headless\", defaulting to"
					einfo "USE=\"headless\", this build will not include any X11/Qt frontend."
					einfo ""
			fi
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Remove shipped binaries (kBuild,yasm), see bug #232775
	rm -rf kBuild/bin tools

	# Don't build things unused or splitted into separate ebuilds (eg: additions)
	epatch "${FILESDIR}/${P}-remove-unused.patch"

	# Fix Insecure temp file usage, see bug #245958
	epatch "${FILESDIR}/${PN}-fix-insecure-lockfiles.patch"
}

src_compile() {

	local myconf
	# Don't build vboxdrv kernel module
	myconf="--disable-kmods --disable-qt4"

	if ! use pulseaudio; then
			myconf="${myconf} --disable-pulse"
	fi
	if ! use alsa; then
			myconf="${myconf} --disable-alsa"
	fi
	if ! use headless; then
			if ! use qt3; then
					myconf="${myconf} --disable-qt"
			fi
	else
			myconf="${myconf} --build-headless"
	fi

	./configure --with-gcc="$(tc-getCC)" --with-g++="$(tc-getCXX)" \
	${myconf} || die "configure failed"
	source ./env.sh

	# Force kBuild to respect C[XX]FLAGS and MAKEOPTS (bug #178529)
	# and strip all flags
	strip-flags

	MAKE="kmk" emake TOOL_GCC3_CC="$(tc-getCC)" TOOL_GCC3_CXX="$(tc-getCXX)" \
		TOOL_GCC3_AS="$(tc-getCC)" TOOL_GCC3_AR="$(tc-getAR)" \
		TOOL_GCC3_LD="$(tc-getCXX)" TOOL_GCC3_LD_SYSMOD="$(tc-getLD)" \
		TOOL_GCC3_CFLAGS="${CFLAGS}" TOOL_GCC3_CXXFLAGS="${CXXFLAGS}" \
		TOOL_YASM_AS=yasm \
		all || die "kmk failed"
}

src_install() {
	cd "${S}"/out/linux.${ARCH}/release/bin

	# create virtualbox configurations files
	insinto /etc/vbox
	newins "${FILESDIR}/${PN}-1-config" vbox.cfg
	newins "${FILESDIR}/${PN}-interfaces" interfaces

	insinto /opt/VirtualBox
	if use sdk; then
		doins -r sdk
		fowners root:vboxusers /opt/VirtualBox/sdk/bin/xpidl
		fperms 0750 /opt/VirtualBox/sdk/bin/xpidl
	fi

	rm -rf sdk src tst* testcase xpidl SUPInstall SUPUninstall VBox.png \
	VBoxBFE vditool VBoxSysInfo.sh vboxkeyboard.tar.gz

	doins -r *

	if ! use headless; then
			for each in VBox{Manage,SDL,SVC,XPCOMIPCD,Tunctl,Headless} ; do
				fowners root:vboxusers /opt/VirtualBox/${each}
				fperms 0750 /opt/VirtualBox/${each}
			done

			if use qt3; then
				fowners root:vboxusers /opt/VirtualBox/VirtualBox
				fperms 0750 /opt/VirtualBox/VirtualBox

				dosym /opt/VirtualBox/VBox.sh /usr/bin/VirtualBox
			fi

			dosym /opt/VirtualBox/VBox.sh /usr/bin/VBoxSDL

			newicon	"${S}"/src/VBox/Frontends/VirtualBox/images/OSE/VirtualBox_32px.png ${PN}.png
			domenu "${FILESDIR}"/${PN}.desktop
	else
			for each in VBox{Manage,SVC,XPCOMIPCD,Tunctl,Headless} ; do
				fowners root:vboxusers /opt/VirtualBox/${each}
				fperms 0750 /opt/VirtualBox/${each}
			done
	fi

	exeinto /opt/VirtualBox
	newexe "${FILESDIR}/${PN}-1-wrapper" "VBox.sh" || die
	fowners root:vboxusers /opt/VirtualBox/VBox.sh
	fperms 0750 /opt/VirtualBox/VBox.sh
	newexe "${S}"/src/VBox/Installer/linux/VBoxAddIF.sh "VBoxAddIF.sh" || die
	fowners root:vboxusers /opt/VirtualBox/VBoxAddIF.sh
	fperms 0750 /opt/VirtualBox/VBoxAddIF.sh

	dosym /opt/VirtualBox/VBox.sh /usr/bin/VBoxManage
	dosym /opt/VirtualBox/VBox.sh /usr/bin/VBoxVRDP
	dosym /opt/VirtualBox/VBox.sh /usr/bin/VBoxHeadless
	dosym /opt/VirtualBox/VBoxTunctl /usr/bin/VBoxTunctl
	dosym /opt/VirtualBox/VBoxAddIF.sh /usr/bin/VBoxAddIF
	dosym /opt/VirtualBox/VBoxAddIF.sh /usr/bin/VBoxDeleteIF
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	elog ""
	if ! use headless; then
			elog "To launch VirtualBox just type: \"VirtualBox\""
	fi
	elog "You must be in the vboxusers group to use VirtualBox."
	elog ""
	elog "The last user manual is available for download at:"
	elog "http://www.virtualbox.org/download/UserManual.pdf"
	elog ""
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
