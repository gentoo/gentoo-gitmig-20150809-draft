# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/tbass/tbass-3.4.ebuild,v 1.1 2004/07/27 00:49:41 chrb Exp $

inherit eutils

IUSE=""
Name="balsa"
My_PV="3.4"

DESCRIPTION="The Balsa asynchronous synthesis system"
HOMEPAGE="http://www.cs.man.ac.uk/amulet/projects/balsa/"
SRC_URI="ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/${My_PV}/${Name}-${My_PV}.tar.gz
	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/${My_PV}/BalsaManual${My_PV}.pdf
	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/${My_PV}/${Name}-tech-example-${My_PV}.tar.gz
	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/${My_PV}/${Name}-sim-verilog-${My_PV}.tar.gz
	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/${My_PV}/BalsaExamples${My_PV}.tar.gz"
#	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/snapshots/${Name}-tech-verilog-20030204.tar.gz
#	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/snapshots/${Name}-tech-xilinx-20021029.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/libc
	sys-devel/binutils
	dev-libs/gmp
	dev-lang/perl
	x11-libs/gtk+
	app-sci/iverilog
	app-sci/gplcver"

RDEPEND="${DEPEND}
	dev-util/guile
	media-gfx/graphviz
	app-sci/gtkwave
	app-sci/espresso-ab"

RESTRICT="fetch nostrip"

pkg_nofetch() {
	einfo "Please try emerging app-sci/balsa instead"
}
