# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/ical/ical-2.2.1.ebuild,v 1.7 2004/04/07 18:50:00 vapier Exp $

inherit eutils

PATCH_VER="0.1"
MY_P=${P}a
S=${WORKDIR}/${MY_P}
DESCRIPTION="Tk-based Calendar program"
HOMEPAGE="http://www.fnal.gov/docs/products/tktools/ical.html"
SRC_URI="http://helios.dii.utk.edu/ftp/pub/tcl/apps/ical/${MY_P}.tar.bz2
	 http://www.ibiblio.org/gentoo/distfiles/${MY_P}.patch-${PATCH_VER}.tar.bz2"

LICENSE="as-is GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="dev-lang/tcl
	dev-lang/tk"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}

	epatch ${MY_P}-newtcl.patch
	epatch ${MY_P}-hack.patch
	epatch ${MY_P}-glibc22.patch
	epatch ${MY_P}-print.patch

	sed -i \
		-e "s: \@TCL_LIBS\@::" \
		-e "s:mkdir:mkdir -p:" \
		Makefile.in

	has_version '=dev-lang/tcl-8.4*' && epatch ${MY_P}-tcl8.4.patch
}

src_compile() {
	autoconf
	econf --with-tclsh=/usr/bin/tclsh || die
	emake || make || die "parallel make failed"
}

src_install() {
	einstall || die "install failed"
}
