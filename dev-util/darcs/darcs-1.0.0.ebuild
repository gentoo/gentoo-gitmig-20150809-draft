# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/darcs/darcs-1.0.0.ebuild,v 1.1 2004/11/08 13:29:55 kosmikus Exp $

DESCRIPTION="David's Advanced Revision Control System is yet another replacement for CVS"
HOMEPAGE="http://abridgegame.org/darcs"
SRC_URI="http://abridgegame.org/darcs/${P/_rc/rc}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"
# disabled wxwindows use flag for now, as I got build errors

DEPEND=">=net-misc/curl-7.10.2
	>=virtual/ghc-6.2
	wxwindows?  ( dev-haskell/wxhaskell )
	doc?  ( virtual/tetex
		dev-tex/latex2html )"

RDEPEND=">=net-misc/curl-7.10.2"
#	wxwindows?  ( dev-haskell/wxhaskell )"

S=${WORKDIR}/${P/_rc/rc}

src_compile() {
	local myconf
#	myconf="`use_with wxwindows wx`"
	# distribution contains garbage files
	make clean || die "make clean failed"
	if use doc ; then
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
		chmod u+x configure
	fi
	econf ${myconf} || die "configure failed"
	echo 'INSTALLWHAT=installbin' >> autoconf.mk
	make all || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
