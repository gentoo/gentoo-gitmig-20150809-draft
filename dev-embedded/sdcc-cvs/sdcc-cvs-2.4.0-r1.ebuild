# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/sdcc-cvs/sdcc-cvs-2.4.0-r1.ebuild,v 1.4 2005/07/28 13:00:24 dragonheart Exp $


ECVS_SERVER="cvs.sourceforge.net:/cvsroot/sdcc"
ECVS_MODULE="sdcc"

inherit cvs

S=${WORKDIR}/${ECVS_MODULE}
DESCRIPTION="Small device C compiler (for various microprocessors, sources from CVS)"
HOMEPAGE="http://sdcc.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64"
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
	!dev-embedded/sdcc"

src_compile() {
	econf || die "Configure failed"
	emake || die "Make failed"
	if use doc
	then
		emake -C doc || die "Making documentation failed"
	fi
}

src_install() {
	emake DESTDIR=${D} install || die "Make install failed"
	dodoc ChangeLog doc/README.txt doc/libdoc.txt doc/INSTALL.txt
	if use doc
	then
		emake -C doc docdir=${D}/usr/share/doc/${PF} install || die "Make install on documentation failed"
	fi
}
