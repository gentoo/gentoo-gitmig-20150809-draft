# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/darcs/darcs-0.9.15.ebuild,v 1.1 2003/12/16 16:14:15 kosmikus Exp $

DESCRIPTION="David's Advanced Revision Control System is yet another replacement for CVS"
HOMEPAGE="http://abridgegame.org/darcs"
SRC_URI="http://abridgegame.org/darcs/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND=">=net-ftp/curl-7.10.2
	>=virtual/ghc-5.04
	doc?  ( virtual/tetex
		dev-tex/latex2html )"

RDEPEND=">=net-ftp/curl-7.10.2"

S=${WORKDIR}/${P}

src_compile() {
	if [ `use doc` ]; then
		mv GNUmakefile GNUmakefile.orig
		cat GNUmakefile.orig \
			| sed "s:/doc:/doc/${PF}:" \
			> GNUmakefile
	else
		mv configure configure.orig
		cat configure.orig \
			| sed 's: installdocs::' \
			| sed 's:^.*BUILDDOC.*yes.*$::' \
			| sed 's/^.*TARGETS.*\(darcs\.ps\|manual\).*$/:/' \
			> configure
	fi
	sh ./configure \
		--prefix=/usr \
		--datadir=/usr/share \
		--sysconfdir=/etc \
		--mandir=/usr/share/man || die
		echo 'INSTALLWHAT=installbin' >> autoconf.mk
	make all || die
}

src_install() {
	make DESTDIR=${D} install || die
}
