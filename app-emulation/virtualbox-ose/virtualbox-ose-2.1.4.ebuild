# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtualbox-ose/virtualbox-ose-2.1.4.ebuild,v 1.1 2009/03/03 07:11:05 patrick Exp $

EAPI=2

inherit eutils fdo-mime flag-o-matic linux-info pax-utils qt4 toolchain-funcs

MY_P=VirtualBox-${PV}-OSE
DESCRIPTION="Softwarefamily of powerful x86 virtualization"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://download.virtualbox.org/virtualbox/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+additions alsa +hal headless pulseaudio python +qt4 sdk vboxwebsrv"

RDEPEND="!app-emulation/virtualbox-bin
	~app-emulation/virtualbox-modules-${PV}
	dev-libs/libIDL
	>=dev-libs/libxslt-1.1.19
	!headless? (
		qt4? ( || ( ( x11-libs/qt-gui x11-libs/qt-core ) =x11-libs/qt-4.3*:4 ) )
		x11-libs/libXcursor
		media-libs/libsdl[X]
		x11-libs/libXt )"
DEPEND="${RDEPEND}
	>=dev-util/kbuild-0.1.5
	>=dev-lang/yasm-0.6.2
	sys-devel/bin86
	sys-devel/dev86
	sys-power/iasl
	media-libs/libpng
	sys-libs/libcap
	alsa? ( >=media-libs/alsa-lib-1.0.13 )
	hal? ( sys-apps/hal )
	pulseaudio? ( media-sound/pulseaudio )
	python? ( >=dev-lang/python-2.3 )
	vboxwebsrv? ( <=net-libs/gsoap-2.7.9f )"
RDEPEND="${RDEPEND}
	additions? ( ~app-emulation/virtualbox-ose-additions-${PV} )
	sys-apps/usermode-utilities
	net-misc/bridge-utils"

S=${WORKDIR}/${MY_P/-OSE/_OSE}
MY_LIBDIR="$(get_libdir)"

pkg_setup() {
	if ! use headless; then
			if ! use qt4; then
					einfo ""
					einfo "No USE=\"qt4\" selected, this build will not include"
					einfo "any Qt frontend."
					einfo ""
			fi
	else
			if use qt4; then
					einfo ""
					einfo "You selected USE=\"headless qt4\", defaulting to"
					einfo "USE=\"headless\", this build will not include any X11/Qt frontend."
					einfo ""
			fi
	fi
}

src_prepare() {
	# Remove shipped binaries (kBuild,yasm), see bug #232775
	rm -rf kBuild/bin tools

	# Disable things unused or splitted into separate ebuilds
	cp "${FILESDIR}/${PN}-2-localconfig" LocalConfig.kmk

	# Disable the VBoxNetFlt kernel driver
	sed -i \
			-e "s/MY_LIBDIR/${MY_LIBDIR}/" LocalConfig.kmk \
			|| die "LocalConfig.kmk sed failed"

	# Fix an upstream typo in Config.kmk
	sed -i \
			-e "2511d" Config.kmk || die "Config.kmk sed failed"
}

src_configure() {
	local myconf
	# Don't build vboxdrv kernel module, disable deprecated qt3 support
	myconf="--disable-kmods --disable-qt3"

	if ! use alsa; then
			myconf="${myconf} --disable-alsa"
	fi
	if ! use pulseaudio; then
			myconf="${myconf} --disable-pulse"
	fi
	if ! use python; then
			myconf="${myconf} --disable-python"
	fi
	if ! use hal; then
			myconf="${myconf} --disable-dbus"
	fi
	if ! use headless; then
			if ! use qt4; then
					myconf="${myconf} --disable-qt4"
			fi
	else
			myconf="${myconf} --build-headless"
	fi
	if use vboxwebsrv; then
			myconf="${myconf} --enable-webservice"
	fi

	./configure --with-gcc="$(tc-getCC)" --with-g++="$(tc-getCXX)" \
	${myconf} || die "configure failed"
}

src_compile() {
	source ./env.sh

	# Force kBuild to respect C[XX]FLAGS and MAKEOPTS (bug #178529)
	# and strip all flags
	strip-flags

	MAKE="kmk" emake TOOL_GCC3_CC="$(tc-getCC)" TOOL_GCC3_CXX="$(tc-getCXX)" \
		TOOL_GCC3_AS="$(tc-getCC)" TOOL_GCC3_AR="$(tc-getAR)" \
		TOOL_GCC3_LD="$(tc-getCXX)" TOOL_GCC3_LD_SYSMOD="$(tc-getLD)" \
		TOOL_GCC3_CFLAGS="${CFLAGS}" TOOL_GCC3_CXXFLAGS="${CXXFLAGS}" \
		TOOL_YASM_AS=yasm KBUILD_PATH="${S}/kBuild" \
		all || die "kmk failed"
}

src_install() {
	cd "${S}"/out/linux.${ARCH}/release/bin

	# Create configuration files
	insinto /etc/vbox
	newins "${FILESDIR}/${PN}-2-config" vbox.cfg

	# Set the right libdir
	sed -i \
			-e "s/MY_LIBDIR/${MY_LIBDIR}/" \
			"${D}"/etc/vbox/vbox.cfg || die "vbox.cfg sed failed"

	# Symlink binaries to the shipped wrapper
	exeinto /usr/${MY_LIBDIR}/${PN}
	newexe "${FILESDIR}/${PN}-2-wrapper" "VBox" || die
	fowners root:vboxusers /usr/${MY_LIBDIR}/${PN}/VBox
	fperms 0750 /usr/${MY_LIBDIR}/${PN}/VBox

	dosym /usr/${MY_LIBDIR}/${PN}/VBox /usr/bin/VBoxManage
	dosym /usr/${MY_LIBDIR}/${PN}/VBox /usr/bin/VBoxVRDP
	dosym /usr/${MY_LIBDIR}/${PN}/VBox /usr/bin/VBoxHeadless
	dosym /usr/${MY_LIBDIR}/${PN}/VBoxTunctl /usr/bin/VBoxTunctl

	# Install binaries and libraries
	insinto /usr/${MY_LIBDIR}/${PN}
	doins -r components

	if use sdk; then
		doins -r sdk
	fi

	if use vboxwebsrv; then
		doins vboxwebsrv
		fowners root:vboxusers /usr/${MY_LIBDIR}/${PN}/vboxwebsrv
		fperms 0750 /usr/${MY_LIBDIR}/${PN}/vboxwebsrv
		dosym /usr/${MY_LIBDIR}/${PN}/VBox /usr/bin/vboxwebsrv
		newinitd "${FILESDIR}"/vboxwebsrv-initd vboxwebsrv
		newconfd "${FILESDIR}"/vboxwebsrv-confd vboxwebsrv
	fi

	for each in VBox{Manage,SVC,XPCOMIPCD,Tunctl} *so *r0 *gc ; do
		doins $each
		fowners root:vboxusers /usr/${MY_LIBDIR}/${PN}/${each}
		fperms 0750 /usr/${MY_LIBDIR}/${PN}/${each}
	done

	if use amd64; then
		doins VBoxREM2.rel
		fowners root:vboxusers /usr/${MY_LIBDIR}/${PN}/VBoxREM2.rel
		fperms 0750 /usr/${MY_LIBDIR}/${PN}/VBoxREM2.rel
	fi

	if ! use headless; then
			for each in VBox{SDL,Headless} ; do
				doins $each
				fowners root:vboxusers /usr/${MY_LIBDIR}/${PN}/${each}
				fperms 4750 /usr/${MY_LIBDIR}/${PN}/${each}
				pax-mark -m "${D}"/usr/${MY_LIBDIR}/${PN}/${each}
			done

			dosym /usr/${MY_LIBDIR}/${PN}/VBox /usr/bin/VBoxSDL

			if use qt4; then
				doins VirtualBox
				fowners root:vboxusers /usr/${MY_LIBDIR}/${PN}/VirtualBox
				fperms 4750 /usr/${MY_LIBDIR}/${PN}/VirtualBox
				pax-mark -m "${D}"/usr/${MY_LIBDIR}/${PN}/VirtualBox

				dosym /usr/${MY_LIBDIR}/${PN}/VBox /usr/bin/VirtualBox
			fi

			newicon	"${S}"/src/VBox/Frontends/VirtualBox/images/OSE/VirtualBox_32px.png ${PN}.png
			domenu "${FILESDIR}"/${PN}.desktop
	else
			doins VBoxHeadless
			fowners root:vboxusers /usr/${MY_LIBDIR}/${PN}/VBoxHeadless
			fperms 4750 /usr/${MY_LIBDIR}/${PN}/VBoxHeadless
			pax-mark -m "${D}"/usr/${MY_LIBDIR}/${PN}/VBoxHeadless
	fi

	insinto /usr/share/${PN}
	doins -r nls
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
	elog "http://download.virtualbox.org/virtualbox/${PV}/UserManual.pdf"
	elog ""
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
