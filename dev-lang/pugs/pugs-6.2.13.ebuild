# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pugs/pugs-6.2.13.ebuild,v 1.1 2006/10/18 19:44:21 yuval Exp $

inherit perl-module multilib eutils

MY_P="Perl6-Pugs-${PV}"
S="${WORKDIR}/-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Pugs is an implementation of Perl 6, written in Haskell"
HOMEPAGE="http://pugscode.org/"
SRC_URI="mirror://cpan/authors/id/A/AU/AUDREYT/${MY_P}.tar.gz"
LICENSE="|| ( Artistic GPL-2 )"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

IUSE=""

DEPEND="dev-perl/Term-ReadLine-Perl
		|| ( >=dev-lang/ghc-bin-6.4.2 >=dev-lang/ghc-6.4.2 )
		>=dev-lang/parrot-0.4.6"

export PARROT_PATH="/usr/$(get_libdir)/parrot"
#this links against parrot and perl5 - if threads was used to compile perl5 this is not supported here
export PUGS_EMBED="parrot perl5"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-build_dir.patch
}
