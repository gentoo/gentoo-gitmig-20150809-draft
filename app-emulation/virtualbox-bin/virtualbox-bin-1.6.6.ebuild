# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtualbox-bin/virtualbox-bin-1.6.6.ebuild,v 1.5 2009/01/04 22:12:47 ulm Exp $

EAPI=1

inherit eutils fdo-mime qt3 pax-utils

MY_P=VirtualBox-${PV}-Linux

DESCRIPTION="Family of powerful x86 virtualization products for enterprise as well as home use"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="amd64? ( ${MY_P}_amd64.run )
	x86? ( ${MY_P}_x86.run )"

LICENSE="PUEL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+additions headless sdk vboxwebsrv"

RDEPEND="!app-emulation/virtualbox-ose
	!app-emulation/virtualbox-ose-additions
	~app-emulation/virtualbox-modules-${PV}
	!headless? (
		x11-libs/qt:3
		x11-libs/libXcursor
		media-libs/libsdl
		x11-libs/libXrender
		x11-libs/libXfixes
		media-libs/libmng
		media-libs/jpeg
		media-libs/libpng
		x11-libs/libXi
		x11-libs/libXrandr
		x11-libs/libXinerama
		x11-libs/libXft
		media-libs/freetype
		media-libs/fontconfig
		x11-libs/libXext )
	x11-libs/libXt
	dev-libs/libxml2
	x11-libs/libXau
	x11-libs/libX11
	x11-libs/libSM
	x11-libs/libICE
	x11-libs/libXdmcp
	sys-apps/usermode-utilities
	net-misc/bridge-utils
	x86? ( =virtual/libstdc++-3.3 )
	sdk? ( dev-libs/libIDL )"

S=${WORKDIR}

RESTRICT="fetch"

pkg_nofetch() {
	# Fetch restriction added due licensing and problems downloading with
	# wget, see http://www.virtualbox.org/ticket/2148
	elog "Please download the package from:"
	elog ""
	if use amd64 ; then
		elog "http://download.virtualbox.org/virtualbox/${PV}/${MY_P}_amd64.run"
	else
		elog "http://download.virtualbox.org/virtualbox/${PV}/${MY_P}_x86.run"
	fi
	elog ""
	elog "and then put it in ${DISTDIR}"
}

pkg_setup() {
	# The VBoxSDL frontend needs media-libs/libsdl compiled
	# with USE flag X enabled (bug #177335)
	if ! use headless ; then
		if ! built_with_use media-libs/libsdl X ; then
			eerror "media-libs/libsdl was compiled without the \"X\" USE flag enabled."
			eerror "Please re-emerge media-libs/libsdl with USE=\"X\"."
			die "media-libs/libsdl should be compiled with the \"X\" USE flag."
		fi
	fi
}

src_unpack() {
	unpack_makeself
	unpack ./VirtualBox.tar.bz2
}

src_install() {
	if ! use headless ; then
		newicon VBox.png virtualbox.png
		newmenu "${FILESDIR}"/${PN}.desktop ${PN}.desktop
	fi

	# create virtualbox configurations files
	insinto /etc/vbox
	newins "${FILESDIR}/${PN}-config" vbox.cfg
	newins "${FILESDIR}/${PN}-interfaces" interfaces

	insinto /opt/VirtualBox
	doins UserManual.pdf

	if use additions; then
		doins -r additions
	fi
	if use sdk; then
		doins -r sdk
		fowners root:vboxusers /opt/VirtualBox/sdk/bin/xpidl
		fperms 0750 /opt/VirtualBox/sdk/bin/xpidl
		pax-mark -m "${D}"/opt/VirtualBox/sdk/bin/xpidl
	fi
	if use vboxwebsrv; then
		doins vboxwebsrv
		fowners root:vboxusers /opt/VirtualBox/vboxwebsrv
		fperms 0750 /opt/VirtualBox/vboxwebsrv
		dosym /opt/VirtualBox/VBox.sh /usr/bin/vboxwebsrv
		newinitd "${FILESDIR}"/vboxwebsrv-initd vboxwebsrv
		newconfd "${FILESDIR}"/vboxwebsrv-confd vboxwebsrv
	fi

	rm -rf src sdk tst* rdesktop-vrdp.tar.gz deffiles install* routines.sh \
		runlevel.sh vboxdrv.sh VBox.sh VBox.png kchmviewer additions VirtualBox.desktop \
		VirtualBox.tar.bz2 vboxnet.sh LICENSE VBoxSysInfo.sh rdesktop* vboxwebsrv webtest

	if use headless ; then
		rm -rf VBoxSDL VirtualBox VBoxKeyboard.so VirtualBoxAPI.chm \
			VirtualBox.chm
	fi

	doins -r * || die

	if ! use headless ; then
		for each in VBox{Manage,SDL,SVC,XPCOMIPCD,Tunctl,Headless} VirtualBox; do
			fowners root:vboxusers /opt/VirtualBox/${each}
			fperms 0750 /opt/VirtualBox/${each}
			pax-mark -m "${D}"/opt/VirtualBox/${each}
		done

		dosym /opt/VirtualBox/VBox.sh /usr/bin/VirtualBox
		dosym /opt/VirtualBox/VBox.sh /usr/bin/VBoxSDL
	else
		for each in VBox{Manage,SVC,XPCOMIPCD,Tunctl,Headless} ; do
			fowners root:vboxusers /opt/VirtualBox/${each}
			fperms 0750 /opt/VirtualBox/${each}
			pax-mark -m "${D}"/opt/VirtualBox/${each}
		done
	fi

	exeinto /opt/VirtualBox
	newexe "${FILESDIR}/${PN}-1-wrapper" "VBox.sh" || die
	fowners root:vboxusers /opt/VirtualBox/VBox.sh
	fperms 0750 /opt/VirtualBox/VBox.sh
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
	if ! use headless ; then
		elog "To launch VirtualBox just type: \"VirtualBox\""
		elog ""
		elog "In order to use the online help, create a link"
		elog "to your favourite chm viewer, for example:"
		elog "ln -s /usr/bin/kchmviewer /opt/VirtualBox/kchmviewer"
		elog ""
	fi
	elog "You must be in the vboxusers group to use VirtualBox."
	elog ""
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
