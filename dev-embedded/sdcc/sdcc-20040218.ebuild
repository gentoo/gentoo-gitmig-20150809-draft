# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/sdcc/sdcc-20040218.ebuild,v 1.1 2004/02/19 04:31:57 dragonheart Exp $

inherit eutils
S=${WORKDIR}/${PN}

DESCRIPTION="SDCC  is a Freeware, retargettable, optimizing ANSI - C compiler. The current version targets the Intel 8051, Maxim/Dallas 80DS390/400 and the  Zilog Z80 based MCUs."
SRC_URI="http://sdcc.sourceforge.net/snapshots/sdcc-src/${PN}-src-x86-linux2.cf.sourceforge.net-${PV}.tar.gz"
HOMEPAGE="http://sdcc.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE="doc"

DEPEND="virtual/glibc
	sys-apps/gawk
	sys-devel/libtool
	sys-apps/grep
	sys-devel/bison
	doc? ( dev-tex/latex2html )
	doc? ( app-text/tetex )
	doc? ( app-office/lyx )
	doc? ( sys-apps/sed )"


RDEPEND="virtual/glibc"


src_compile() {

# Clear CFLAGS... breaks with my Flags!
#       unset CFLAGS CXXFLAGS
	cd ${S}
# Fix doc directory
	echo "docdir          = @datadir@/doc/${P}" >> Makefile.common.in
	echo "docdir          = \$(datadir)/doc/${P}/usim" >> sim/ucsim/doc/Makefile.in
	./configure --prefix=/usr || die "configure failed"
	emake

	# Echo  - couple of errors in the doc.
	use doc && echo -e "\n\n" | emake -j1 -C doc
}

src_install() {
	einstall || die
	dodoc README COPYING ChangeLog
	use doc && emake -C doc docdir=${D}/usr/share/doc/sdcc-20040217/ install
}