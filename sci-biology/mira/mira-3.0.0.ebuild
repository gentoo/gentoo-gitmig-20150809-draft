# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/mira/mira-3.0.0.ebuild,v 1.1 2010/02/03 03:06:22 weaver Exp $

EAPI="2"

inherit base

DESCRIPTION="Whole Genome Shotgun and EST Sequence Assembler for Sanger, 454 and Solexa / Illumina"
HOMEPAGE="http://www.chevreux.org/projects_mira.html"
SRC_URI="mirror://sourceforge/mira-assembler/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE="doc"
KEYWORDS="~amd64 ~x86"

CDEPEND=">=dev-libs/boost-1.35.0"
DEPEND="${CDEPEND}
	dev-libs/expat
	doc? ( >=app-text/texlive-core-2009 )"
RDEPEND="${CDEPEND}"

src_prepare() {
	find -name configure -or -name 'Makefile*' | xargs sed -i 's/flex++/flex -+/' || die
}

src_compile() {
	base_src_compile
	if use doc; then emake -C doc clean docs || die; fi
}

src_install() {
	einstall || die
	dodoc AUTHORS GETTING_STARTED NEWS README* HELP_WANTED THANKS INSTALL
	find doc/docs/man -type f | xargs doman
	find doc/docs/texinfo -type f | xargs doinfo
}
