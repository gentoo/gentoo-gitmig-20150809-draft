# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Spiffy/Spiffy-0.30.ebuild,v 1.1 2006/02/20 00:00:52 mcummings Exp $

inherit perl-module

DESCRIPTION="Spiffy Perl Interface Framework For You"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/I/IN/INGY/${P}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-lang/perl-5.6.1"
