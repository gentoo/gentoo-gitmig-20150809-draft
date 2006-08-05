# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-stringy/IO-stringy-2.109.ebuild,v 1.13 2006/08/05 04:48:02 mcummings Exp $

inherit perl-module

DESCRIPTION="A Perl module for I/O on in-core objects like strings and arrays"
HOMEPAGE="http://www.cpan.org/modules/by-module/IO/ERYQ/${P}.readme"
SRC_URI="mirror://cpan/authors/id/E/ER/ERYQ/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 s390 sparc x86"
IUSE=""

SRC_TEST="do"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
