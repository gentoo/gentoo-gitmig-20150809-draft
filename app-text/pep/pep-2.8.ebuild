# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pep/pep-2.8.ebuild,v 1.3 2004/04/08 22:55:45 vapier Exp $

inherit eutils

DESCRIPTION="Pep is a general purpose filter and file cleaning program"
HOMEPAGE="http://folk.uio.no/gisle/enjoy/pep.html"
SRC_URI="http://folk.uio.no/gisle/enjoy/${PN}${PV//./}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="app-arch/unzip
	virtual/glibc"
RDEPEND="virtual/glibc"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	# pep does not come with autconf so here's a patch to configure
	# Makefile with the correct path
	epatch ${FILESDIR}/${P}-gentoo.patch || die "epatch failed"
}

src_compile() {
	# make man page too
	make Doc/pep.1 || die "make man page failed"
	emake || die "emake failed"
}

src_install() {
	dobin pep || die
	doman Doc/pep.1

	insinto /usr/share/pep
	doins Filters/*

	dodoc aareadme.txt file_id.diz
}
