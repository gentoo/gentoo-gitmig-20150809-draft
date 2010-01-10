# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-tk/perl-tk-804.028-r3.ebuild,v 1.1 2010/01/10 19:59:01 grobian Exp $

MODULE_AUTHOR="SREZIC"
MY_PN=Tk
MY_P=${MY_PN}-${PV}
inherit eutils multilib perl-module

DESCRIPTION="A Perl Module for Tk"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="x11-libs/libX11
	x11-libs/libXft
	media-libs/freetype
	media-libs/libpng
	media-libs/jpeg
	dev-lang/perl"

S=${WORKDIR}/${MY_P}

# No test running here, requires an X server, and fails lots anyway.
SRC_TEST="skip"

PATCHES=( "${FILESDIR}"/xorg.patch
	"${FILESDIR}"/${PV}-MouseWheel.patch
	"${FILESDIR}"/${PV}-FBox.patch
	"${FILESDIR}"/${PV}-path.patch
	"${FILESDIR}"/${PN}-CVE-2008-0553.patch
	"${FILESDIR}"/${PN}-804.027-interix-x11.patch )

myconf="X11ROOT=${EPREFIX}/usr XFT=1 -I${EPREFIX}/usr/include/ -l${EPREFIX}/usr/$(get_libdir)"
mydoc="ToDo VERSIONS"
