# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/sdcc-svn/sdcc-svn-2.5.0.ebuild,v 1.2 2007/09/14 08:56:31 dragonheart Exp $

ESVN_REPO_URI="https://sdcc.svn.sourceforge.net/svnroot/sdcc/trunk/sdcc"

inherit subversion

DESCRIPTION="Small device C compiler (for various microprocessors, sources from Subversion repository)"
HOMEPAGE="http://sdcc.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

DEPEND=">=dev-embedded/gputils-0.13.2
	dev-libs/boehm-gc
	doc? ( >=app-office/lyx-1.3.4 )"
RDEPEND="!dev-embedded/sdcc
	!dev-embedded/sdcc-cvs"

src_unpack() {
	subversion_src_unpack
	cd ${S}

	# Fix conflicting variable names between Gentoo and sdcc
	find ./ -type f -exec sed -i s:PORTDIR:PORTINGDIR:g  {} \; || die "sed failed"
	find device/lib/pic*/ -type f -exec sed -i s:ARCH:SDCCARCH:g  {} \; || die "sed failed"
	find device/lib/pic/libdev/ -type f -exec sed -i s:CFLAGS:SDCCFLAGS:g  {} \; || die "sed failed"

	# --as-needed fix :
	sed -i -e "s/= @CURSES_LIBS@ @LIBS@/= @CURSES_LIBS@ @LIBS@ -lcurses/" sim/ucsim/gui.src/serio.src/Makefile.in || die "sed failed"
}

src_compile() {
	econf --enable-libgc docdir=/usr/share/doc/${PF} || die "Configure failed"
	emake || die "Make failed"
	if use doc ; then
		cd doc
		lyx -e html cdbfileformat
		lyx -e html sdccman
		lyx -e html test_suite_spec
	fi
}

src_install() {
	emake DESTDIR=${D} install || die "Make install failed"
	if use doc ; then
		cd doc
		insinto /usr/share/doc/${PF}
		doins cdbfileformat.html sdccman.html test_suite_spec.html
	fi
}
