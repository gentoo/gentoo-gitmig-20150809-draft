# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pugs/pugs-6.2.3.ebuild,v 1.2 2005/07/09 16:01:29 swegener Exp $

inherit perl-module

MY_P="Perl6-Pugs-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Pugs is an implementation of Perl 6, written in Haskell"
HOMEPAGE="http://pugscode.org/"
SRC_URI="mirror://cpan/authors/id/A/AU/AUTRIJUS/${MY_P}.tar.gz"
LICENSE="|| ( Artistic GPL-2 )"

SRC_TEST="do"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

IUSE=""

DEPEND="dev-perl/Term-ReadLine-Perl
		virtual/ghc"

