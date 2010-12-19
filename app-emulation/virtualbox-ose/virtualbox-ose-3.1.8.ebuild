# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtualbox-ose/virtualbox-ose-3.1.8.ebuild,v 1.13 2010/12/19 11:18:07 polynomial-c Exp $

EAPI=2

inherit eutils fdo-mime flag-o-matic linux-info pax-utils qt4-r2 toolchain-funcs

if [[ ${PV} == "9999" ]] ; then
	# XXX: should finish merging the -9999 ebuild into this one ...
	ESVN_REPO_URI="http://www.virtualbox.org/svn/vbox/trunk"
	inherit linux-mod subversion
else
	MY_P=VirtualBox-${PV}-OSE
	SRC_URI="http://download.virtualbox.org/virtualbox/${PV}/${MY_P}.tar.bz2"
	S=${WORKDIR}/${MY_P/-OSE/_OSE}
fi

DESCRIPTION="Software family of powerful x86 virtualization"
HOMEPAGE="http://www.virtualbox.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+additions alsa headless pulseaudio python +qt4 sdk vboxwebsrv"

RDEPEND="!app-emulation/virtualbox-bin
	~app-emulation/virtualbox-modules-${PV}
	dev-libs/libIDL
	>=dev-libs/libxslt-1.1.19
	net-misc/curl
	!headless? (
		qt4? ( x11-libs/qt-gui:4 x11-libs/qt-core:4 x11-libs/qt-opengl:4 )
		virtual/opengl
		media-libs/freeglut
		x11-libs/libXcursor
		media-libs/libsdl[X,video]
		x11-libs/libXt
	)
	headless? ( x11-libs/libX11 )"
DEPEND="${RDEPEND}
	>=dev-util/kbuild-0.1.5-r1
	>=dev-lang/yasm-0.6.2
	sys-devel/bin86
	sys-devel/dev86
	sys-power/iasl
	media-libs/libpng
	sys-libs/libcap
	dev-util/pkgconfig
	alsa? ( >=media-libs/alsa-lib-1.0.13 )
	pulseaudio? ( media-sound/pulseaudio )
	python? ( >=dev-lang/python-2.3[threads] )
	vboxwebsrv? ( >=net-libs/gsoap-2.7.13 )"
RDEPEND="${RDEPEND}
	additions? ( ~app-emulation/virtualbox-ose-additions-${PV} )"

QA_TEXTRELS_x86="usr/lib/virtualbox-ose/VBoxGuestPropSvc.so
	usr/lib/virtualbox-ose/VBoxSDL.so
	usr/lib/virtualbox-ose/VBoxSharedFolders.so
	usr/lib/virtualbox-ose/VBoxDD2.so
	usr/lib/virtualbox-ose/VBoxOGLrenderspu.so
	usr/lib/virtualbox-ose/VBoxPython.so
	usr/lib/virtualbox-ose/VBoxDD.so
	usr/lib/virtualbox-ose/VBoxDDU.so
	usr/lib/virtualbox-ose/VBoxREM64.so
	usr/lib/virtualbox-ose/VBoxSharedClipboard.so
	usr/lib/virtualbox-ose/VBoxHeadless.so
	usr/lib/virtualbox-ose/VBoxRT.so
	usr/lib/virtualbox-ose/VBoxREM.so
	usr/lib/virtualbox-ose/VBoxSettings.so
	usr/lib/virtualbox-ose/VBoxKeyboard.so
	usr/lib/virtualbox-ose/VBoxSharedCrOpenGL.so
	usr/lib/virtualbox-ose/VBoxVMM.so
	usr/lib/virtualbox-ose/VirtualBox.so
	usr/lib/virtualbox-ose/VBoxOGLhosterrorspu.so
	usr/lib/virtualbox-ose/components/VBoxC.so
	usr/lib/virtualbox-ose/components/VBoxSVCM.so
	usr/lib/virtualbox-ose/components/VBoxDDU.so
	usr/lib/virtualbox-ose/components/VBoxRT.so
	usr/lib/virtualbox-ose/components/VBoxREM.so
	usr/lib/virtualbox-ose/components/VBoxVMM.so
	usr/lib/virtualbox-ose/VBoxREM32.so
	usr/lib/virtualbox-ose/VBoxPython2_4.so
	usr/lib/virtualbox-ose/VBoxPython2_5.so
	usr/lib/virtualbox-ose/VBoxPython2_6.so
	usr/lib/virtualbox-ose/VBoxXPCOMC.so
	usr/lib/virtualbox-ose/VBoxOGLhostcrutil.so
	usr/lib/virtualbox-ose/VBoxNetDHCP.so"

pkg_setup() {
	if ! use headless && ! use qt4 ; then
		einfo "No USE=\"qt4\" selected, this build will not include"
		einfo "any Qt frontend."
	elif use headless && use qt4 ; then
		einfo "You selected USE=\"headless qt4\", defaulting to"
		einfo "USE=\"headless\", this build will not include any X11/Qt frontend."
	fi
}

src_prepare() {
	# Remove shipped binaries (kBuild,yasm), see bug #232775
	rm -rf kBuild/bin tools

	# Disable things unused or split into separate ebuilds
	sed -e "s/MY_LIBDIR/$(get_libdir)/" \
		"${FILESDIR}"/${PN}-3-localconfig > LocalConfig.kmk || die

	# unset useless/problematic mesa checks in configure
	epatch "${FILESDIR}/${PN}-3.0.0-mesa-check.patch"

	# fix with newer iasl (bug #319127)
	epatch "${FILESDIR}/${P}-iasl-length-calculation-fix.patch"
}

src_configure() {
	local myconf
	use alsa       || myconf="${myconf} --disable-alsa"
	use pulseaudio || myconf="${myconf} --disable-pulse"
	use python     || myconf="${myconf} --disable-python"
	use vboxwebsrv && myconf="${myconf} --enable-webservice"
	if ! use headless ; then
		use qt4 || myconf="${myconf} --disable-qt4"
	else
		myconf="${myconf} --build-headless"
	fi
	# not an autoconf script
	./configure \
		--with-gcc="$(tc-getCC)" \
		--with-g++="$(tc-getCXX)" \
		--disable-kmods \
		--disable-dbus \
		${myconf} \
		|| die "configure failed"
}

src_compile() {
	source ./env.sh

	# Force kBuild to respect C[XX]FLAGS and MAKEOPTS (bug #178529)
	# and strip all flags
	strip-flags

	MAKE="kmk" emake \
		TOOL_GCC3_CC="$(tc-getCC)" TOOL_GCC3_CXX="$(tc-getCXX)" \
		TOOL_GCC3_AS="$(tc-getCC)" TOOL_GCC3_AR="$(tc-getAR)" \
		TOOL_GCC3_LD="$(tc-getCXX)" TOOL_GCC3_LD_SYSMOD="$(tc-getLD)" \
		TOOL_GCC3_CFLAGS="${CFLAGS}" TOOL_GCC3_CXXFLAGS="${CXXFLAGS}" \
		TOOL_YASM_AS=yasm KBUILD_PATH="${S}/kBuild" \
		all || die "kmk failed"
}

src_install() {
	cd "${S}"/out/linux.*/release/bin || die

	# Create configuration files
	insinto /etc/vbox
	newins "${FILESDIR}/${PN}-3-config" vbox.cfg

	# Set the right libdir
	sed -i \
		-e "s/MY_LIBDIR/$(get_libdir)/" \
		"${D}"/etc/vbox/vbox.cfg || die "vbox.cfg sed failed"

	# Symlink binaries to the shipped wrapper
	exeinto /usr/$(get_libdir)/${PN}
	newexe "${FILESDIR}/${PN}-3-wrapper" "VBox" || die
	fowners root:vboxusers /usr/$(get_libdir)/${PN}/VBox
	fperms 0750 /usr/$(get_libdir)/${PN}/VBox

	dosym /usr/$(get_libdir)/${PN}/VBox /usr/bin/VBoxManage
	dosym /usr/$(get_libdir)/${PN}/VBox /usr/bin/VBoxVRDP
	dosym /usr/$(get_libdir)/${PN}/VBox /usr/bin/VBoxHeadless
	dosym /usr/$(get_libdir)/${PN}/VBoxTunctl /usr/bin/VBoxTunctl

	# Install binaries and libraries
	insinto /usr/$(get_libdir)/${PN}
	doins -r components || die

	if use sdk ; then
		doins -r sdk || die
	fi

	if use vboxwebsrv ; then
		doins vboxwebsrv || die
		fowners root:vboxusers /usr/$(get_libdir)/${PN}/vboxwebsrv
		fperms 0750 /usr/$(get_libdir)/${PN}/vboxwebsrv
		dosym /usr/$(get_libdir)/${PN}/VBox /usr/bin/vboxwebsrv
		newinitd "${FILESDIR}"/vboxwebsrv-initd vboxwebsrv
		newconfd "${FILESDIR}"/vboxwebsrv-confd vboxwebsrv
	fi

	for each in VBox{Manage,SVC,XPCOMIPCD,Tunctl,NetAdpCtl,NetDHCP} *so *r0 *gc ; do
		doins $each || die
		fowners root:vboxusers /usr/$(get_libdir)/${PN}/${each}
		fperms 0750 /usr/$(get_libdir)/${PN}/${each}
	done
	# VBoxNetAdpCtl binary needs to be suid root in any case..
	fperms 4750 /usr/$(get_libdir)/${PN}/VBoxNetAdpCtl

	if ! use headless ; then
		for each in VBox{SDL,Headless} ; do
			doins $each || die
			fowners root:vboxusers /usr/$(get_libdir)/${PN}/${each}
			fperms 4750 /usr/$(get_libdir)/${PN}/${each}
			pax-mark -m "${D}"/usr/$(get_libdir)/${PN}/${each}
		done

		dosym /usr/$(get_libdir)/${PN}/VBox /usr/bin/VBoxSDL

		if use qt4 ; then
			doins VirtualBox || die
			fowners root:vboxusers /usr/$(get_libdir)/${PN}/VirtualBox
			fperms 4750 /usr/$(get_libdir)/${PN}/VirtualBox
			pax-mark -m "${D}"/usr/$(get_libdir)/${PN}/VirtualBox

			doins VBoxTestOGL || die
			fowners root:vboxusers /usr/$(get_libdir)/${PN}/VBoxTestOGL
			fperms 0750 /usr/$(get_libdir)/${PN}/VBoxTestOGL

			dosym /usr/$(get_libdir)/${PN}/VBox /usr/bin/VirtualBox
		fi

		newicon	"${S}"/src/VBox/Frontends/VirtualBox/images/OSE/VirtualBox_32px.png ${PN}.png
		domenu "${FILESDIR}"/${PN}.desktop
	else
		doins VBoxHeadless || die
		fowners root:vboxusers /usr/$(get_libdir)/${PN}/VBoxHeadless
		fperms 4750 /usr/$(get_libdir)/${PN}/VBoxHeadless
		pax-mark -m "${D}"/usr/$(get_libdir)/${PN}/VBoxHeadless
	fi

	insinto /usr/share/${PN}
	if ! use headless && use qt4 ; then
		doins -r nls
	fi

	# set an env-variable for 3rd party tools
	echo -n "VBOX_APP_HOME=/usr/$(get_libdir)/${PN}" > "${T}/90virtualbox"
	doenvd "${T}/90virtualbox"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	if ! use headless && use qt4 ; then
		elog "To launch VirtualBox just type: \"VirtualBox\""
	fi
	elog "You must be in the vboxusers group to use VirtualBox."
	elog ""
	elog "The latest user manual is available for download at:"
	elog "http://download.virtualbox.org/virtualbox/${PV}/UserManual.pdf"
	elog ""
	elog "For advanced networking setups you should emerge:"
	elog "net-misc/bridge-utils and sys-apps/usermode-utilities"
	elog ""
	elog "Please visit http://www.virtualbox.org/wiki/Editions for"
	elog "an overview about the different features of ${PN}"
	elog "and virtualbox-bin"
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
