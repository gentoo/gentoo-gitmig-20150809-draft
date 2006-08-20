# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Time-modules/Time-modules-2003.0211.ebuild,v 1.8 2006/08/20 01:24:11 mcummings Exp $

inherit perl-module

DESCRIPTION="A Date/Time Parsing Perl Module"
HOMEPAGE="http://www.cpan.org/modules/by-module/Time/MUIR/modules/${P}.readme"
SRC_URI="mirror://cpan/authors/id/M/MU/MUIR/modules/${P}.tar.gz"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc ~sparc alpha"

mymake="/usr"


DEPEND="dev-lang/perl"
