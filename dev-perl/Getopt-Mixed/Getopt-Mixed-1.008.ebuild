# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Getopt-Mixed/Getopt-Mixed-1.008.ebuild,v 1.14 2006/08/05 04:11:56 mcummings Exp $

inherit perl-module

DESCRIPTION="Getopt::Mixed is used for parsing mixed options"
HOMEPAGE="http://www.cpan.org/modules/by-module/Getopt/${P}.readme"
SRC_URI="mirror://cpan/authors/id/C/CJ/CJM/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
