# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pugs/pugs-6.0.11.ebuild,v 1.2 2005/03/17 21:06:04 mcummings Exp $

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

DEPEND="dev-perl/Term-ReadLine-Perl
		||( >=dev-lang/ghc-bin-6.2.1 >=dev-lang/ghc-6.2.1 ) "

