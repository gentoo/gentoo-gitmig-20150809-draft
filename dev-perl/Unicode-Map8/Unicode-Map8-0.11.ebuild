# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unicode-Map8/Unicode-Map8-0.11.ebuild,v 1.5 2002/07/25 04:56:39 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A Unicode Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/Unicode/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/Unicode/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86"

DEPEND="${DEPEND}
	>=dev-perl/Unicode-String-2.06"

mydoc="TODO"
