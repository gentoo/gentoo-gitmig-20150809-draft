# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pugs/pugs-6.0.11.ebuild,v 1.1 2005/03/14 14:43:20 mcummings Exp $

inherit perl-module

MY_P="Perl6-Pugs-${PV}"
S="${WORKDIR}/-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Pugs is an implementation of Perl 6, written in Haskell"
HOMEPAGE="http://pugscode.org/"
SRC_URI="mirror://cpan/authors/id/A/AU/AUTRIJUS/${MY_P}.tar.gz"
LICENSE="|| ( Artistic GPL-2 )"

SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

# Not sure how kosher this approach is - basically didn't want to force
# the user to compile ghc if they didn't already have a copy - but didn't want
# to force ghc-bin if they had a copy of ghc already installed.

if has "dev-lang/ghc" ; then
	DEPEND=">=dev-lang/ghc-6.2.1
			dev-perl/Term-ReadLine-Perl"
else
	DEPEND=">=dev-lang/ghc-bin-6.2.1
			dev-perl/Term-ReadLine-Perl"
fi

#TODO:
#headers for readline are missing -> does not work yet !
		#readline? (>=dev-perl/Term-ReadLine-Perl-1.0203
		#>=sys-libs/readline-4.3-r5)

