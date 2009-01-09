# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Plucene/Plucene-1.25.ebuild,v 1.8 2009/01/09 18:07:06 tove Exp $

inherit perl-module

DESCRIPTION="Plucene - the Perl lucene port"
HOMEPAGE="http://search.cpan.org/~tmtm/"
SRC_URI="mirror://cpan/authors/id/T/TM/TMTM/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"

RDEPEND=">=dev-lang/perl-5.8.4
		virtual/perl-Memoize
		dev-perl/Tie-Array-Sorted
		dev-perl/Encode-compat
		dev-perl/File-Slurp
		dev-perl/Class-Virtual
		dev-perl/Class-Accessor
		virtual/perl-Time-Piece
		virtual/perl-File-Spec
		>=virtual/perl-Scalar-List-Utils-1.13
		dev-perl/Lingua-Stem
		dev-perl/Bit-Vector-Minimal
		dev-perl/IO-stringy"
DEPEND="${RDEPEND}
		>=virtual/perl-Test-Harness-2.30
		>=virtual/perl-Module-Build-0.28"
