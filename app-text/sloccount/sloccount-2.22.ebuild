# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sloccount/sloccount-2.22.ebuild,v 1.1 2003/06/04 13:59:17 lu_zero Exp $

DESCRIPTION="A set of tools for counting physical Source Lines of Code (SLOC) in a large number of languages of a potentially large set of programs."

HOMEPAGE="http://www.dwheeler.com/sloccount/"

SRC_URI="http://www.dwheeler.com/sloccount/${P}.tar.gz"

LICENSE="GPL-1"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND="dev-lang/perl
        app-shells/bash"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S};

	# Patch to move most of the executables out of /usr/bin
	# and into /usr/libexec/sloccount to avoid conflicts.
	epatch ${FILESDIR}/${P}-libexec.patch
}

src_compile() {
	make -f makefile PREFIX=/usr
}

src_install() {
	make -f makefile install PREFIX=${D}/usr
}
