# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/linuxwacom/linuxwacom-0.6.9.ebuild,v 1.3 2005/08/10 19:20:54 eradicator Exp $

IUSE="dlloader gtk gtk2 tcltk sdk usb"

inherit multilib eutils

DESCRIPTION="Input driver for Wacom tablets and drawing devices"
HOMEPAGE="http://linuxwacom.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="virtual/x11
	gtk? (
		gtk2? ( >=x11-libs/gtk+-2 )
		!gtk2? ( =x11-libs/gtk+-1.2* )
	)
	tcltk? ( dev-lang/tcl dev-lang/tk )
	sys-libs/ncurses"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	usb? ( >=sys-kernel/linux-headers-2.6 )
	>=sys-apps/sed-4"

pkg_setup() {
	if use sdk; then
		if ! built_with_use xorg-x11 sdk
		then
			eerror "This package builds against the X.Org SDK, and therefore requires"
			eerror "that you have emerged xorg-x11 with the sdk USE flag enabled."
			die "Please remerge xorg-x11 with the sdk USE flag enabled."
		fi
		einfo "Building against the X11 SDK. This will install updated X drivers and userland tools."
	else
		ewarn "The 'sdk' use flag is not set. Only building userland tools. If you wish to install"
		ewarn "the updated external driver for your X server, please remerge your X11 package with"
		ewarn "the USE=sdk flag enabled."
	fi
}

src_unpack() {
	unpack ${A}

	if use sdk; then
		cd ${S}

		# Simple fixes to configure to check the actual location of the XFree86 SDK
		# No need to check if just building userland tools
		sed -i -e "s:XF86SUBDIR=.*:XF86SUBDIR=include:" configure
		sed -i -e "s:XF86V3SUBDIR=.*:XF86V3SUBDIR=include:" configure
	fi
}

src_compile() {
	if use gtk; then
		if use gtk2; then
			myconf="${myconf} --with-gtk=2.0"
		else
			myconf="${myconf} --with-gtk=1.2"
		fi
	else
		myconf="${myconf} --with-gtk=no"
	fi

	if use tcltk ; then
		myconf="${myconf} --with-tcl --with-tk"
	else
		myconf="${myconf} --without-tcl --without-tk"
	fi

	if use amd64 ; then
		myconf="${myconf} --enable-xserver64"
	fi
	myconf="${myconf} --with-xorg-sdk=/usr/$(get_libdir)/Server/ --with-xlib=/usr/$(get_libdir)"

	if use sdk; then
		myconf="${myconf} --enable-wacomdrv --enable-wacdump --enable-xsetwacom"
		myconf="${myconf} --with-xf86=/usr/$(get_libdir)/Server --with-xorg-sdk=/usr/$(get_libdir)/Server"

		if use dlloader || has_version ">=x11-base/xorg-x11-6.8.99.15" ; then
			myconf="${myconf} --enable-dlloader"
		fi

		econf ${myconf} || die "configure failed."

		# Makefile fix for build against SDK
		cd ${S}/src
		sed -i -e "s:/include/extensions:/include:g" Makefile
	else
		myconf="${myconf} --disable-wacomdrv --enable-wacdump --enable-xsetwacom"
		econf ${myconf} || die "configure failed."
	fi
	cd ${S}
	unset ARCH
	emake || die "build failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed."
	dohtml -r docs/*
	dodoc AUTHORS ChangeLog NEWS README
}
