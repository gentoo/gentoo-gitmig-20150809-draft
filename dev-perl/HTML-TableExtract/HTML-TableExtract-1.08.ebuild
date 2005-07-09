# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-TableExtract/HTML-TableExtract-1.08.ebuild,v 1.13 2005/07/09 22:41:09 swegener Exp $

inherit perl-module

MY_P=${P/.3_/c-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="The Perl Table-Extract Module"
SRC_URI="mirror://cpan/authors/id/M/MS/MSISK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/HTML/${MY_P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha ~ppc64"
IUSE=""

mydoc="TODO"
