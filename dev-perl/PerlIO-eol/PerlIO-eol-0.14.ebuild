# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PerlIO-eol/PerlIO-eol-0.14.ebuild,v 1.5 2007/07/10 23:33:33 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="PerlIO::eol - PerlIO layer for normalizing line endings"
SRC_URI="mirror://cpan/authors/id/A/AU/AUDREYT/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~autrijus/"

SLOT="0"
LICENSE="Artistic"
SRC_TEST="do"
KEYWORDS="amd64 ~ia64 ~ppc sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"
