# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-pt/aspell-pt-20041027.ebuild,v 1.1 2005/02/15 21:53:44 arj Exp $

ASPELL_LANG="Portuguese"

LICENSE="GPL-2"

inherit eutils

DESCRIPTION="${ASPELL_LANG} language dictionary for aspell"
SRC_URI="http://natura.di.uminho.pt/download/sources/Dictionaries/aspell/aspell.pt.${PV}.tar.gz"
HOMEPAGE="http://natura.di.uminho.pt"
S=${WORKDIR}/portugues

IUSE=""
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/Makefile-fix
	epatch ${FILESDIR}/configure-new
	chmod +x configure
}

src_compile() {
	./configure
	emake || die "make failed"
}

src_install() {
	addwrite "/usr/lib/"
	emake install || die "make failed"
}
