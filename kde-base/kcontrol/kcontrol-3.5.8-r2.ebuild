# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcontrol/kcontrol-3.5.8-r2.ebuild,v 1.1 2008/01/11 20:40:20 tgurr Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-10.tar.bz2"

DESCRIPTION="The KDE Control Center"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="arts ieee1394 joystick logitech-mouse opengl kdehiddenvisibility"

DEPEND=">=media-libs/freetype-2.3
	media-libs/fontconfig
	dev-libs/openssl
	arts? ( $(deprange 3.5.5 $MAXKDEVER kde-base/arts) )
	opengl? ( virtual/opengl )
	ieee1394? ( sys-libs/libraw1394 )
	logitech-mouse? ( >=dev-libs/libusb-0.1.10a )"

RDEPEND="${DEPEND}
	sys-apps/usbutils
	$(deprange 3.5.6 $MAXKDEVER kde-base/kcminit)
	$(deprange $PV $MAXKDEVER kde-base/kdebase-data)
	$(deprange 3.5.7-r1 $MAXKDEVER kde-base/kdesu)
	$(deprange $PV $MAXKDEVER kde-base/khelpcenter)
	$(deprange $PV $MAXKDEVER kde-base/khotkeys)
	$(deprange $PV $MAXKDEVER kde-base/libkonq)
	$(deprange $PV $MAXKDEVER kde-base/kicker)"

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

src_unpack() {
	kde-meta_src_unpack unpack

	if ! use joystick ; then
		sed -e 's:$(JOYSTICK_SUBDIR)::' \
			-e 's:kthememanager \\:kthememanager:' \
			-i "${S}/kcontrol/Makefile.am" \
		|| die "sed failed"
	fi
	if ! use arts ; then
		sed -e 's:arts::' \
			-i "${S}/kcontrol/Makefile.am" \
		|| die "sed failed"
	fi

	kde-meta_src_unpack makefiles
}

src_compile() {
	myconf="$myconf --with-ssl $(use_with arts) $(use_with opengl gl)
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
