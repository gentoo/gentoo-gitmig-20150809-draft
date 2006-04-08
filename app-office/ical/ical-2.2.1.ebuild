# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/ical/ical-2.2.1.ebuild,v 1.16 2006/04/08 09:14:09 blubb Exp $

inherit eutils

PATCH_VER="0.1"
MY_P="${P}a"
DESCRIPTION="Tk-based Calendar program"
HOMEPAGE="http://www.fnal.gov/docs/products/tktools/ical.html"
SRC_URI="http://helios.dii.utk.edu/ftp/pub/tcl/apps/ical/${MY_P}.tar.bz2
	 	mirror://gentoo/${MY_P}.patch-${PATCH_VER}.tar.bz2"

LICENSE="as-is GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

RDEPEND="dev-lang/tcl
	dev-lang/tk"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	sys-devel/autoconf"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"

	epatch ${MY_P}-newtcl.patch
	epatch ${MY_P}-hack.patch
	epatch ${MY_P}-glibc22.patch
	epatch ${MY_P}-print.patch

	sed -i \
		-e "s: \@TCL_LIBS\@::" \
		-e "s:mkdir:mkdir -p:" \
		"${S}"/Makefile.in \
		|| die "sed Makefile.in failed"

	has_version '=dev-lang/tcl-8.4*' && epatch ${MY_P}-tcl8.4.patch
}

src_compile() {
	# don't use autoconf, bug 101658
	# autoconf
	econf --with-tclsh=/usr/bin/tclsh || die
	emake -j1 || die "make failed"
}

src_install() {
	einstall \
		MANDIR="${D}/usr/share/man" || die "install failed"
}
