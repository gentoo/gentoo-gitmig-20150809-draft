# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/sdcc/sdcc-2.5.0.ebuild,v 1.2 2005/07/28 12:50:37 dragonheart Exp $

DESCRIPTION="Small device C compiler (for various microprocessors)"
HOMEPAGE="http://sdcc.sourceforge.net/"
SRC_URI="mirror://sourceforge/sdcc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
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
		emake -C doc || die "Making documentation failed"
	}
}

src_install() {
	emake DESTDIR=${D} install || die "Make install failed"
	dodoc ChangeLog doc/README.txt doc/libdoc.txt doc/INSTALL.txt
	use doc && emake -C doc docdir=${D}/usr/share/doc/${P}/ install
}
