# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hmake/hmake-3.07.ebuild,v 1.1 2003/04/22 08:27:53 kosmikus Exp $

DESCRIPTION="a make tool for Haskell programs"

HOMEPAGE="http://www.haskell.org/hmake/"

LICENSE="nhc98"

KEYWORDS="~x86"
SLOT="0"
IUSE="nhc98"

# hmake can be build with either ghc or nhc98; we prefer ghc
# unless a use flag tells us otherwise
DEPEND="nhc98?  ( dev-lang/nhc98 )
	!nhc98? ( virtual/ghc )"

RDEPEND="${DEPEND}"

SRC_URI="http://www.cs.york.ac.uk/ftpdir/pub/haskell/hmake/${P}.tar.gz"

src_compile() {
	if [ "`use nhc98`" ]; then
		buildwith="--buildwith=nhc98"
		# Makefile is erroneous; we need to fix it
		pushd hmake-3.07
			mv Makefile Makefile.orig
			sed -e "s/^TARGETS.*=/TARGETS = hmake-nhc hi-nhc/" \
				Makefile.orig > Makefile
		popd
	else
		buildwith="--buildwith=ghc"
	fi
	# package uses non-standard configure, therefore econf does
	# not work ...
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man/man1 \
		${buildwith} || die "./configure failed"
	
	# emake tested; does not work
	make || die "make failed"
}

src_install () {
	make DESTDIR=${D} install || die

	# install HTML documentation
	cd docs/hmake
	dohtml *
}
