# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/magic/magic-7.5.40.ebuild,v 1.2 2007/01/31 18:19:42 calchan Exp $

DESCRIPTION="The VLSI design CAD tool."
HOMEPAGE="http://www.opencircuitdesign.com/magic/index.html"
SRC_URI="http://www.opencircuitdesign.com/magic/archive/${P}.tgz \
	ftp://ftp.mosis.edu/pub/sondeen/magic/new/beta/2002a.tar.gz"

# This is a development version. Do not keyword without contacting maintainer as we add/remove these at random.
LICENSE="as-is GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="sys-libs/ncurses
	sys-libs/readline
	dev-lang/tcl
	dev-lang/tk
	dev-tcltk/blt"
DEPEND="${RDEPEND}
	app-shells/tcsh"

src_compile() {
	# Short-circuit top-level configure script to retain CFLAGS
	cd scripts
	econf --libdir=/usr/share || die "Configuration failed"
	cd ..
	emake || die "Compilation failed"
}

src_install() {
	emake DESTDIR=${D} install || die "Installation failed"
	dodoc README README.Tcl TODO

	# Install latest MOSIS tech files
	cp -pPR ${WORKDIR}/2002a ${D}/usr/share/magic/sys/current
}
