# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/lout/lout-3.25-r1.ebuild,v 1.9 2004/04/08 22:54:20 vapier Exp $

inherit eutils

DESCRIPTION="high-level language for document formatting"
HOMEPAGE="http://snark.ptc.spbu.ru/~uwe/lout/"
SRC_URI="http://www.tex.ac.uk/tex-archive/support/lout/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND=">=sys-libs/zlib-1.1.4"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}

	# Apply the makefile patch, this is the only configuration so far :-(
	epatch ${FILESDIR}/${P}-r1-makefile-gentoo.patch
}

src_compile() {
	emake prg2lout lout || die "emake prg2lout lout failed"
}

src_install() {
	emake DESTDIR=${D} install installdoc installman || die "emake install failed"
	dodoc README READMEPDF blurb blurb.short whatsnew
}

pkg_postinst() {
	/usr/bin/lout -x -s /usr/lib/lout/include/init
	chmod 644 /usr/lib/lout/data/*
	chmod 644 /usr/lib/lout/hyph/*
}
