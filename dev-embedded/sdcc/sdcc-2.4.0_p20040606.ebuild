# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/sdcc/sdcc-2.4.0_p20040606.ebuild,v 1.4 2004/07/18 06:27:08 dragonheart Exp $

MY_PV=${PV/*_p/}
DESCRIPTION="Small device C compiler (for various microprocessors)"
HOMEPAGE="http://sdcc.sourceforge.net/"
SRC_URI="http://sdcc.sourceforge.net/snapshots/sdcc-src/${PN}-src-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
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
RDEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_compile() {
	econf || die "Configure failed"
	emake || die "Make failed"
	use doc && {
		emake -C doc || die "Making documentation failed"
	}
}

src_install() {
	einstall || die "Make install failed"
	dodoc ChangeLog doc/README.txt doc/libdoc.txt doc/INSTALL.txt
	use doc && emake -C doc docdir=${D}/usr/share/doc/${P}/ install
}
