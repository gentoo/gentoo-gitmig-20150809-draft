# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unix-Syslog/Unix-Syslog-0.100-r1.ebuild,v 1.13 2006/08/06 00:56:26 mcummings Exp $

inherit perl-module

DESCRIPTION="A Perl module which provides access to the system logger"
SRC_URI="mirror://cpan/authors/id/M/MH/MHARNISCH/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Unix/MHARNISCH/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
