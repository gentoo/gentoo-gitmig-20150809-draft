# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Plucene/Plucene-1.19.ebuild,v 1.1 2004/10/06 23:22:25 mcummings Exp $

inherit perl-module

DESCRIPTION=""
HOMEPAGE="http://search.cpan.org/~simon/${P}/"
SRC_URI="mirror://cpan/authors/id/S/SI/SIMON/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""
style="builder"

SRC_TEST="do"

DEPEND=">=dev-lang/perl-5.8.4
		dev-perl/module-build
		dev-perl/Memoize
		dev-perl/Tie-Array-Sorted
		dev-perl/Encode-compat
		dev-perl/File-Slurp
		dev-perl/Class-Virtual
		dev-perl/Class-Accessor
		dev-perl/Time-Piece
		dev-perl/Test-Harness
		dev-perl/Lingua-Stem
		dev-perl/Bit-Vector-Minimal
		dev-perl/Class-Accessor
		dev-perl/IO-stringy"
