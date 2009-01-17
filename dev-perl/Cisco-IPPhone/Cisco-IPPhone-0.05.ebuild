# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cisco-IPPhone/Cisco-IPPhone-0.05.ebuild,v 1.3 2009/01/17 22:29:44 robbat2 Exp $

inherit perl-module

S=${WORKDIR}/Cisco-IPPhone-0.05

DESCRIPTION="Cisco IP Phone interface using XML Objects"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/M/MR/MRPALMER/Cisco-IPPhone-0.05.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
