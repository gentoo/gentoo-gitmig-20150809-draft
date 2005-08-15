# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pugs/pugs-6.2.9.ebuild,v 1.1 2005/08/15 08:17:02 mcummings Exp $

inherit perl-module

MY_P="Perl6-Pugs-${PV}"
MY_PARROT="parrot-0.2.3"
S="${WORKDIR}/-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Pugs is an implementation of Perl 6, written in Haskell"
HOMEPAGE="http://pugscode.org/"
SRC_URI="mirror://cpan/authors/id/A/AU/AUTRIJUS/${MY_P}.tar.gz"
LICENSE="|| ( Artistic GPL-2 )"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

IUSE=""

DEPEND="dev-perl/Term-ReadLine-Perl
		|| ( >=dev-lang/ghc-bin-6.4 >=dev-lang/ghc-6.4 )
		=dev-lang/${MY_PARROT}"
#not yet supported because the 0.9.8 version does not work with ghc-6.4 that is required for pugs

export PARROT_PATH="/usr/lib/${MY_PARROT}"
#this links against parrot and perl5 - if threads was used to compile perl5 this is not supported here
export PUGS_EMBED="parrot perl5"
#del upon ghc-6.4.1 release
export GHCRTS='-A200M'
