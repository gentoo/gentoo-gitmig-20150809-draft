# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/darcs/darcs-1.0.2.ebuild,v 1.3 2005/03/24 15:14:31 kosmikus Exp $

DESCRIPTION="David's Advanced Revision Control System is yet another replacement for CVS"
HOMEPAGE="http://abridgegame.org/darcs"
SRC_URI="http://abridgegame.org/darcs/${P/_rc/rc}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="doc"
# disabled wxwindows use flag for now, as I got build errors

DEPEND=">=net-misc/curl-7.10.2
	>=virtual/ghc-6.2
	!>=virtual/ghc-6.4
	doc?  ( virtual/tetex
		dev-tex/latex2html )"
#	wxwindows?  ( dev-haskell/wxhaskell )

RDEPEND=">=net-misc/curl-7.10.2"
#	wxwindows?  ( dev-haskell/wxhaskell )"

S=${WORKDIR}/${P/_rc/rc}

src_compile() {
	local myconf
#	myconf="`use_with wxwindows wx`"
	# distribution contains garbage files
	make clean || die "make clean failed"
	if use doc ; then
		sed -i "s:/doc:/doc/${PF}:" GNUmakefile
	else
		sed -i \
			-e 's: installdocs::' \
			-e 's:^.*BUILDDOC.*yes.*$::' \
			-e 's/^.*TARGETS.*\(darcs\.ps\|manual\).*$/:/' \
			configure
	fi
	econf ${myconf} || die "configure failed"
	echo 'INSTALLWHAT=installbin' >> autoconf.mk
	make all || die "make failed"
}

src_test() {
	make test
}

src_install() {
	make DESTDIR=${D} install || die "installation failed"
}
