# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/sdcc/sdcc-2.4.0.ebuild,v 1.2 2004/03/30 14:05:29 dragonheart Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Small device C compiler (for various microprocessors)"
SRC_URI="mirror://sourceforge/sdcc/${P}.tar.gz"
HOMEPAGE="http://sdcc.sourceforge.net/"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE="doc"

DEPEND="virtual/glibc
	sys-apps/gawk
	sys-devel/libtool
	sys-apps/grep
	sys-devel/bison
	doc? ( dev-tex/latex2html
		app-text/tetex
		app-office/lyx
		sys-apps/sed )"

RDEPEND="virtual/glibc"

src_compile() {
	econf || die "Configure failed"
	emake || die "Make failed"
	use doc && {
		echo -e "\n\n" | emake -C doc
		# || die "Making documentation failed"
	}
}

src_install() {
	einstall || die "Make install failed"
	dodoc COPYING ChangeLog doc/README.txt doc/libdoc.txt doc/INSTALL.txt
	use doc && emake -C doc docdir=${D}/usr/share/doc/${P}/ install
}
