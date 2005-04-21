# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/R/R-2.1.0.ebuild,v 1.2 2005/04/21 21:02:31 cryos Exp $

inherit 64-bit fortran

IUSE="blas bzlib gnome jpeg nls pcre png readline tcltk X"
DESCRIPTION="R is GNU S - A language and environment for statistical computing and graphics."
SRC_URI="http://cran.r-project.org/src/base/R-2/${P}.tar.gz"
#There are daily release patches, don't know how to utilize these
#"ftp://ftp.stat.math.ethz.ch/Software/${PN}/${PN}-release.diff.gz"
HOMEPAGE="http://www.r-project.org/"
DEPEND="virtual/libc
		>=dev-lang/perl-5.6.1-r3
		readline? (>=sys-libs/readline-4.1-r3)
		zlib? ( >=sys-libs/zlib-1.1.3-r2 )
		jpeg? ( >=media-libs/jpeg-6b-r2 )
		png? ( >=media-libs/libpng-1.2.1 )
		blas? ( virtual/blas )
		X? ( virtual/x11 )
		tcltk? ( dev-lang/tk )
		pcre? ( dev-libs/libpcre )
		bzlib? ( app-arch/bzip2 )
		gnome? ( >=gnome-base/gnome-libs-1.4.1.4
			>=gnome-base/libglade-0.17
			>=dev-libs/libxml-1.8.16
			=gnome-base/orbit-0*
			>=media-libs/imlib-1.9.10
			>=x11-libs/gtk+-1.2.10
			>=dev-libs/glib-1.2.10
			>=media-sound/esound-0.2.23
			>=media-libs/audiofile-0.2.1 )"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86 ~sparc ~ppc ~ppc64 ~amd64"
64-bit || FORTRAN="g77" # No f2c on 64-bit archs anymore.

src_compile() {
	local myconf="--enable-R-profiling --enable-R-shlib --enable-linux-lfs"

	if use tcltk; then
		#configure needs to find the files tclConfig.sh and tkConfig.sh
		myconf="${myconf} --with-tcltk --with-tcl-config=/usr/lib/tclConfig.sh --with-tk-config=/usr/lib/tkConfig.sh"
	else
		myconf="${myconf} --without-tcltk"
	fi

	econf \
		$(use_enable nls) \
		$(use_with blas) \
		$(use_with bzlib) \
		$(use_with gnome) \
		$(use_with jpeg jpeglib) \
		$(use_with pcre) \
		$(use_with png libpng) \
		$(use_with readline) \
		$(use_with X x) \
		$(use_with zlib) \
		${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		rhome=${D}/usr/$(get_libdir)/R \
		install || die "Installation Failed"

	#fix the R wrapper script to have the correct R_HOME_DIR
	#sed regexp borrowed from included debian rules
	sed \
		-e "/^R_HOME_DIR=.*/s::R_HOME_DIR=/usr/$(get_libdir)/R:" \
		-i ${D}/usr/$(get_libdir)/R/bin/R \
		|| die "sed failed"

	#R installs two identical wrappers under /usr/bin and /usr/lib/R/bin/
	#the 2nd one is corrected by above sed, for the 1st
	#I'll just symlink it into /usr/bin
	cd ${D}/usr/bin/
	rm R
	dosym ../$(get_libdir)/R/bin/R /usr/bin/R
	cd ${S}

	dodoc AUTHORS BUGS COPYING* ChangeLog FAQ *NEWS README \
		RESOURCES THANKS VERSION Y2K

	#Add rudimentary menu entry if gnome
	if use gnome; then
		insinto /usr/share/gnome/apps/Applications
		doins ${FILESDIR}/R.desktop
		insinto /usr/share/pixmaps
		doins ${FILESDIR}/R-logo.png
	fi

}
