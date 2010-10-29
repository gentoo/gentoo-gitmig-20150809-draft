# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/text-template/text-template-1.45.ebuild,v 1.2 2010/10/29 06:28:20 grobian Exp $

MODULE_AUTHOR=MJD
inherit perl-module

MY_P=Text-Template-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Expand template text with embedded Perl"
SRC_URI="mirror://cpan/authors/id/M/MJ/MJD/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/M/MJ/MJD/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86 ~ppc-macos"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST=do
