# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Plucene/Plucene-1.25.ebuild,v 1.6 2007/03/27 11:50:33 ticho Exp $

inherit perl-module

DESCRIPTION="Plucene - the Perl lucene port"
HOMEPAGE="http://search.cpan.org/~tmtm/"
SRC_URI="mirror://cpan/authors/id/T/TM/TMTM/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-lang/perl-5.8.4
		>=dev-perl/module-build-0.28
		virtual/perl-Memoize
		dev-perl/Tie-Array-Sorted
		dev-perl/Encode-compat
		dev-perl/File-Slurp
		dev-perl/Class-Virtual
		dev-perl/Class-Accessor
		dev-perl/Time-Piece
		virtual/perl-File-Spec
		>=virtual/perl-Test-Harness-2.30
		>=virtual/perl-Scalar-List-Utils-1.13
		dev-perl/Lingua-Stem
		dev-perl/Bit-Vector-Minimal
		dev-perl/IO-stringy"
