# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/darcs/darcs-0.9.11.ebuild,v 1.1 2003/07/03 12:43:45 kosmikus Exp $

DESCRIPTION="David's Advanced Revision Control System is yet another replacement for CVS"
HOMEPAGE="http://abridgegame.org/darcs"
SRC_URI="http://abridgegame.org/darcs/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND=">=net-ftp/curl-7.10.2
	>=virtual/ghc-5.04
	doc?  ( >=app-text/tetex-2.0.2
		dev-tex/latex2html )"

RDEPEND=">=net-ftp/curl-7.10.2"

S=${WORKDIR}/${P}

src_compile() {
	# fix typo in autoconf.mk.in
	mv autoconf.mk.in autoconf.mk.in.orig
	cat autoconf.mk.in.orig \
		| sed 's:$(CFLAGS):-optc"$(CFLAGS)":' \
		> autoconf.mk.in
	sh ./configure \
		--prefix=/usr \
		--datadir=/usr/share \
		--sysconfdir=/etc \
		--mandir=/usr/share/man || die
	if [ `use doc` ]; then
		mv GNUmakefile GNUmakefile.orig
		cat GNUmakefile.orig \
			| sed 's:/doc:/doc/${PF}:' \
			> GNUmakefile
	else
		mv GNUmakefile GNUmakefile.orig
		cat GNUmakefile.orig \
			| sed 's:^.*/doc.*$::' \
			> GNUmakefile
		mv autoconf.mk autoconf.mk.orig
		cat autoconf.mk.orig \
			| sed 's:darcs\.ps::' \
			| sed 's:manual/index.html::' \
			> autoconf.mk
	fi		
	make all || die
}

src_install() {
	make DESTDIR=${D} install || die
}
