# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/linuxwacom/linuxwacom-0.6.4.ebuild,v 1.1 2004/10/24 05:47:24 battousai Exp $

DESCRIPTION="Input driver for Wacom tablets and drawing devices"
HOMEPAGE="http://linuxwacom.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="gtk gtk2 tcltk sdk"

RDEPEND="virtual/x11
	gtk? (
		gtk2? ( >=x11-libs/gtk+-2 )
		!gtk2? ( =x11-libs/gtk+-1.2* )
	)
	tcltk? ( dev-lang/tcl dev-lang/tk )
	sys-libs/ncurses"

DEPEND="${RDEPEND}
	sys-devel/libtool
	dev-util/pkgconfig
	>=sys-apps/sed-4"

pkg_setup() {
	if use sdk; then
		if has_version ">=x11-base/xfree-4.3.0-r7"
		then
			if [ ! "`grep sdk /var/db/pkg/x11-base/xfree-[0-9]*/USE`" ]
			then
				eerror "This package builds against the XFree86 SDK, and therefore requires"
				eerror "that you have emerged xfree with the sdk USE flag enabled."
				die "Please remerge xfree with the sdk USE flag enabled."
			fi
		elif has_version "x11-base/xorg-x11"
		then
			if [ ! "`grep sdk /var/db/pkg/x11-base/xorg-x11-[0-9]*/USE`" ]
			then
				eerror "This package builds against the X.Org SDK, and therefore requires"
				eerror "that you have emerged xorg-x11 with the sdk USE flag enabled."
				die "Please remerge xorg-x11 with the sdk USE flag enabled."
			fi
		else die "This build requires x11-base/xorg-x11 or x11-base/xfree to be installed to build against the SDK when USE=sdk."
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
		# Simple fixes to configure to check the actual location of the XFree86 SDK
		# No need to check if just building userland tools
		cd ${S}
		sed -i -e "s:XF86SUBDIR=.*:XF86SUBDIR=include:" configure
		sed -i -e "s:XF86V3SUBDIR=.*:XF86V3SUBDIR=include:" configure
	fi
}

src_compile() {
	if use gtk;
	then
		if use gtk2;
		then
			withgtk="--with-gtk=2.0"
		else
			withgtk="--with-gtk=1.2"
		fi
	else
		withgtk="--with-gtk=no"
	fi
	if use tcltk;
	then
		withtcltk="--with-tcl --with-tk"
	else
		withtcltk="--without-tcl --without-tk"
	fi

	if use sdk; then
		myconf="--enable-wacomdrv --enable-wacdump --enable-xsetwacom --with-xf86=/usr/X11R6/lib/Server $withgtk $withtcltk"
		econf ${myconf} || die "configure failed."

		# Makefile fix for build against SDK
		cd ${S}/src
		cp Makefile Makefile.orig
		sed -i -e "s:XF86_DIR = .*:XF86_DIR = /usr/X11R6/lib/Server:" Makefile
		sed -i -e "s:XF86_V3_DIR = .*:XF86_V3_DIR = /usr/X11R6/lib/Server:" Makefile
		sed -i -e "s:/include/extensions:/include:g" Makefile
	else
		myconf="--disable-wacomdrv --enable-wacdump --enable-xsetwacom $withgtk $withtcltk"
		econf ${myconf} || die "configure failed."
	fi
	cd ${S}
	emake || die "build failed."
}

src_install() {
	emake DESTDIR=${D} install || die "Install failed."
	dohtml -r docs/*
	dodoc AUTHORS ChangeLog NEWS README
}
