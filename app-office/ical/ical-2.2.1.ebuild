# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/ical/ical-2.2.1.ebuild,v 1.5 2004/03/14 01:47:30 mr_bones_ Exp $

PATCH_VER="0.1"
DESCRIPTION="Calendar program"
HOMEPAGE="http://www.fnal.gov/docs/products/tktools/ical.html"
SRC_URI="http://helios.dii.utk.edu/ftp/pub/tcl/apps/ical/${P}a.tar.bz2
		 http://www.ibiblio.org/gentoo/distfiles/${P}a.patch-${PATCH_VER}.tar.bz2"
LICENSE="as-is GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="dev-lang/tcl dev-lang/tk sys-devel/autoconf"
RDEPEND="dev-lang/tcl dev-lang/tk"

S=${WORKDIR}/${P}a

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}

	patch -p0 < ${P}a-newtcl.patch	|| die
	patch -p0 < ${P}a-hack.patch	|| die
	patch -p0 < ${P}a-glibc22.patch	|| die
	patch -p0 < ${P}a-print.patch	|| die

	D=${S}/ dosed "s: \@TCL_LIBS\@::" Makefile.in
	D=${S}/ dosed "s:mkdir:mkdir -p:" Makefile.in

	if has_version '=dev-lang/tcl-8.4*' ; then
		patch -p0 < ${P}a-tcl8.4.patch || die
	fi

}

src_compile() {
	autoconf
	econf --with-tclsh=/usr/bin/tclsh
	emake || die "parallel make failed"
}

src_install () {
	#make DESTDIR=${D} install || die
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die "install failed"
}
