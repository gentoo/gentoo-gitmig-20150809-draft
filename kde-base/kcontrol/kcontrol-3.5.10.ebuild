# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcontrol/kcontrol-3.5.10.ebuild,v 1.11 2009/11/20 03:10:56 ssuominen Exp $

KMNAME=kdebase
EAPI="1"
ARTS_REQUIRED=never
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-13.tar.bz2"

DESCRIPTION="The KDE Control Center"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="ieee1394 joystick logitech-mouse opengl kdehiddenvisibility"

DEPEND="x11-libs/libXext
	x11-libs/libXtst
	x11-libs/libXcursor
	x11-libs/libXrender
	>=media-libs/freetype-2.3
	media-libs/fontconfig
	dev-libs/openssl
	opengl? ( virtual/opengl )
	ieee1394? ( sys-libs/libraw1394 )
	logitech-mouse? ( =virtual/libusb-0* )
	>=kde-base/libkonq-${PV}:${SLOT}
	>=kde-base/kicker-${PV}:${SLOT}"
RDEPEND="${DEPEND}
	sys-apps/usbutils
	>=kde-base/kcminit-${PV}:${SLOT}
	>=kde-base/kdebase-data-${PV}:${SLOT}
	>=kde-base/kdesu-${PV}:${SLOT}
	>=kde-base/khotkeys-${PV}:${SLOT}"

KMEXTRACTONLY="kwin/kwinbindings.cpp
		kicker/kicker/core/kickerbindings.cpp
		kicker/taskbar/taskbarbindings.cpp
		kdesktop/kdesktopbindings.cpp
		klipper/klipperbindings.cpp
		kxkb/kxkbbindings.cpp
		kicker/taskmanager"

KMEXTRA="doc/kinfocenter"
KMCOMPILEONLY="kicker/libkicker
	kicker/taskbar"
KMCOPYLIB="libkonq libkonq
	libkicker kicker/libkicker
	libtaskbar kicker/taskbar
	libtaskmanager kicker/taskmanager"

PATCHES=( "${FILESDIR}/${P}-gcc44.patch" )

src_unpack() {
	kde-meta_src_unpack unpack

	if ! use joystick ; then
		sed -e 's:$(JOYSTICK_SUBDIR)::' \
			-e 's:kthememanager \\:kthememanager:' \
			-i "${S}/kcontrol/Makefile.am" \
		|| die "sed failed"
	fi
	sed -e 's:arts::' \
		-i "${S}/kcontrol/Makefile.am" \
		|| die "sed failed"

	kde-meta_src_unpack makefiles
}

src_compile() {
	myconf="$myconf --with-ssl --without-arts $(use_with opengl gl)
			$(use_with ieee1394 libraw1394) $(use_with logitech-mouse libusb)
			--with-usbids=/usr/share/misc/usb.ids"
	kde-meta_src_compile
}

src_install() {
	kde-meta_src_install

	# Fix an obscure desktop file that only gets generated during the install phase.
	sed -i -e '$d' "${D}/usr/kde/3.5/share/applications/kde/panel_appearance.desktop"
	sed -i -e 's:Name=panel_appearance::' "${D}/usr/kde/3.5/share/applications/kde/panel_appearance.desktop"
}
