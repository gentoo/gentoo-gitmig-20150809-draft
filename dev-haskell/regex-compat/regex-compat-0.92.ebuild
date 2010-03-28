# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/regex-compat/regex-compat-0.92.ebuild,v 1.1 2010/03/28 20:51:51 kolmodin Exp $

CABAL_FEATURES="profile haddock lib"
inherit haskell-cabal

DESCRIPTION="One module layer over regex-posix to replace Text.Regex"
HOMEPAGE="http://sourceforge.net/projects/lazy-regex"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6
		>=dev-haskell/regex-base-0.93
		>=dev-haskell/regex-posix-0.93"
