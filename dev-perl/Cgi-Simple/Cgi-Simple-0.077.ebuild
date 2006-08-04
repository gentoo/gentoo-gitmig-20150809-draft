# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cgi-Simple/Cgi-Simple-0.077.ebuild,v 1.12 2006/08/04 23:00:32 mcummings Exp $

inherit perl-module


DESCRIPTION="A Simple totally OO CGI interface that is CGI.pm compliant"
SRC_URI="mirror://cpan/authors/id/J/JF/JFREEMAN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/JFREEMAN/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"
DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
