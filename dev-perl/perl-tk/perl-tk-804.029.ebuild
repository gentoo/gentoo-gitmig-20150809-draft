# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-tk/perl-tk-804.029.ebuild,v 1.11 2011/08/30 09:26:55 lxnay Exp $

EAPI=3

MODULE_AUTHOR="SREZIC"
MY_PN=Tk
MY_PV=${PV/_p/_}
MY_P=${MY_PN}-${MY_PV}
inherit multilib perl-module

DESCRIPTION="A Perl Module for Tk"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND="x11-libs/libX11
	x11-libs/libXft
	media-libs/freetype
	>=media-libs/libpng-1.4
	virtual/jpeg"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

# No test running here, requires an X server, and fails lots anyway.
SRC_TEST="skip"

PATCHES=( "${FILESDIR}"/xorg.patch
	"${FILESDIR}"/804.028-path.patch
	"${FILESDIR}"/804.029-X11_XLIB_H.patch )
#	"${FILESDIR}"/${PN}-804.027-interix-x11.patch )

myconf="X11ROOT=${EPREFIX}/usr XFT=1 -I${EPREFIX}/usr/include/ -l${EPREFIX}/usr/$(get_libdir)"
mydoc="ToDo VERSIONS"

MAKEOPTS+=" -j1" #333049
