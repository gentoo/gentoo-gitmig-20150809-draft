# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hmake/hmake-3.10.ebuild,v 1.1 2005/03/23 07:37:48 araujo Exp $

inherit base fixheadtails

DESCRIPTION="a make tool for Haskell programs"
HOMEPAGE="http://www.haskell.org/hmake/"
SRC_URI="http://www.haskell.org/hmake/${P}.tar.gz"

LICENSE="nhc98"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""

DEPEND="virtual/ghc
	sys-libs/readline"
RDEPEND="sys-libs/readline
	virtual/libc
	dev-libs/gmp"

# if using readline, hmake depends also on ncurses; but
# readline already has this dependency

src_compile() {
	local buildwith
	local arch

	buildwith="--buildwith=ghc"

	# fix all head/tail declarations
	sed -i 's/tail -1/tail  -n 1/' src/hmake/MkConfig.hs
	# the line above prevents current fixheadtails.eclass from doing nonsense;
	# double space before -n is significant
	ht_fix_all

	# fix string gaps
	sed -i -e 's/\\ $/" ++/' -e 's/^\\/ "/' src/interpreter/HInteractive.hs

	# package uses non-standard configure, therefore econf does
	# not work ...
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man/man1 \
		${buildwith} || die "./configure failed"

	# emake tested; does not work
	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dohtml docs/hmake/*
}
