# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ghc-bin/ghc-bin-6.4.1.ebuild,v 1.5 2006/02/24 10:10:13 dcoutts Exp $

inherit multilib

IUSE="" # use the non-binary version if you want to have more choice

DESCRIPTION="Glasgow Haskell Compiler"
# list all arches for proper digest building:
SRC_URI="x86?  ( mirror://gentoo/${P}-x86.tbz2 )
		 amd64? ( mirror://gentoo/${P}-amd64.tbz2 )
		 alpha? ( mirror://gentoo/${P}-alpha.tbz2 )
		 sparc? ( mirror://gentoo/${P}-sparc.tbz2 )
		 ppc? ( mirror://gentoo/${P}-ppc.tbz2 )"
#		 ppc64? ( mirror://gentoo/${P}-ppc64.tbz2 )
HOMEPAGE="http://www.haskell.org"

LICENSE="as-is"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
# add these when they are ready: ~ppc64
SLOT="0"

RESTRICT="nostrip" # already stripped

LOC="/opt/ghc"

DEPEND=""
RDEPEND=">=dev-lang/perl-5.6.1
	>=sys-devel/gcc-2.95.3
	>=dev-libs/gmp-4.1
	=sys-libs/readline-5*"

PROVIDE="virtual/ghc"

S="${WORKDIR}"

src_compile() {
	sed -i "s|/usr|${LOC}|g" usr/bin/* "usr/$(get_libdir)/ghc-${PV}/package.conf"
	mkdir -p ./${LOC}
	mv usr/* ./${LOC}
}

src_install () {
	cp -pr * "${D}"
	insinto /etc/env.d
	doins "${FILESDIR}/10ghc"
}
