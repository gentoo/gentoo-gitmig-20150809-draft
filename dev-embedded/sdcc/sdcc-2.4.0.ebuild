# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/sdcc/sdcc-2.4.0.ebuild,v 1.10 2004/09/28 07:22:23 dragonheart Exp $

DESCRIPTION="Small device C compiler (for various microprocessors)"
HOMEPAGE="http://sdcc.sourceforge.net/"
SRC_URI="mirror://sourceforge/sdcc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="doc"

DEPEND="virtual/libc
	sys-apps/gawk
	sys-devel/libtool
	sys-apps/grep
	sys-devel/bison
	doc? ( dev-tex/latex2html
		virtual/tetex
		>=app-office/lyx-1.3.4
		sys-apps/sed )"
RDEPEND="virtual/libc
	!dev-embedded/sdcc-cvs"

S=${WORKDIR}/${PN}

src_compile() {
	econf || die "Configure failed"
	emake || die "Make failed"
	use doc && {
		#echo -e "\n\n" | 
		emake -C doc
		# || die "Making documentation failed"
	}
}

src_install() {
	einstall || die "Make install failed"
	dodoc ChangeLog doc/README.txt doc/libdoc.txt doc/INSTALL.txt
	use doc && emake -C doc docdir=${D}/usr/share/doc/${P}/ install
}
