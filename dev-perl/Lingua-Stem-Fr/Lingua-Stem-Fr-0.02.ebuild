# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-Stem-Fr/Lingua-Stem-Fr-0.02.ebuild,v 1.9 2006/08/17 21:29:53 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl French Stemming"
HOMEPAGE="http://search.cpan.org/~sdp/${P}/"
SRC_URI="mirror://cpan/authors/id/S/SD/SDP/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
