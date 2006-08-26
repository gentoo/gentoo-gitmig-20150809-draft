# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/linuxwacom/linuxwacom-0.7.2.ebuild,v 1.1 2006/08/26 02:48:41 hanno Exp $

IUSE="dlloader gtk gtk2 tcltk sdk usb"

inherit multilib eutils linux-info

DESCRIPTION="Input driver for Wacom tablets and drawing devices"
HOMEPAGE="http://linuxwacom.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"

RDEPEND="|| ( ( x11-proto/inputproto
		x11-base/xorg-server )
	      virtual/x11 )
	gtk? (
		gtk2? ( >=x11-libs/gtk+-2 )
		!gtk2? ( =x11-libs/gtk+-1.2* )
	)
	tcltk? ( dev-lang/tcl dev-lang/tk )
	sys-libs/ncurses"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-apps/sed-4"

pkg_setup() {
	if use sdk || has_version ">=x11-base/xorg-server-0.1" ; then
		if ! built_with_use x11-base/xorg-x11 sdk && ! has_version ">=x11-base/xorg-server-0.1"
		then
			eerror "This package builds against the X.Org SDK, and therefore requires"
			eerror "that you have emerged xorg-x11 with the sdk USE flag enabled."
			die "Please remerge xorg-x11 with the sdk USE flag enabled."
		fi
		einfo "Installing X Wacom driver and accompanying userland utilities."
	else
		ewarn "The 'sdk' use flag is not set. Only building userland tools. If you wish to install"
		ewarn "the updated external driver for your X server, please remerge your X11 package with"
		ewarn "the USE=sdk flag enabled."
	fi

	if use usb; then
		if ! has_version ">=sys-kernel/linux-headers-2.6"; then
			if kernel_is 2 6; then
				local msg
				msg="USB Wacom tablets require 2.6 linux-headers. Please upgrade."
				eerror "$msg"
				die "$msg"
			fi
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix multilib-strict error for Tcl/Tk library install
	sed -i -e "s:WCM_EXECDIR/lib:WCM_EXECDIR/$(get_libdir):" configure.in

	if use sdk && ! has_version ">=x11-base/xorg-server-0.1" ; then
		cd ${S}

		# Simple fixes to configure to check the actual location of the XFree86 SDK
		# No need to check if just building userland tools
		sed -i -e "s:XF86SUBDIR=.*:XF86SUBDIR=include:
			   s:XF86V3SUBDIR=.*:XF86V3SUBDIR=include:" configure
	fi

	if has_version ">=x11-base/xorg-server-0.1"; then
		cd ${S}
		epatch ${FILESDIR}/${P}-modular-x.patch
	# moved to end of src_unpack to fix multilib issue -Jon <squinky86@gentoo.org>
	#	autoreconf -v --install
	#	libtoolize --force --copy
	fi
	autoreconf -v --install
	libtoolize --force --copy
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

	if use sdk || has_version ">=x11-base/xorg-server-0.1" ; then
		myconf="${myconf} --enable-wacomdrv --enable-wacdump --enable-xsetwacom"
		has_version ">=x11-base/xorg-server-0.1" || \
			myconf="${myconf} --with-xf86=/usr/$(get_libdir)/Server --with-xorg-sdk=/usr/$(get_libdir)/Server --with-xlib=/usr/$(get_libdir)"

		if use dlloader || has_version ">=x11-base/xorg-x11-6.8.99.15" || has_version ">=x11-base/xorg-server-0.1" ; then
			myconf="${myconf} --enable-dlloader"
		fi

		econf ${myconf} || die "configure failed."

		# Makefile fix for build against SDK
		cd ${S}/src
		sed -i -e "s:/include/extensions:/include:g" Makefile
	else
		myconf="${myconf} --disable-wacomdrv --enable-wacdump --enable-xsetwacom --without-xf86-sdk"
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
