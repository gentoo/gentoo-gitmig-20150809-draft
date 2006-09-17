# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cisco-Reconfig/Cisco-Reconfig-0.8.ebuild,v 1.5 2006/09/17 01:55:58 mcummings Exp $

inherit perl-module

DESCRIPTION="Parse and generate Cisco configuration files"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/M/MU/MUIR/modules/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ~x86"
SRC_TEST="do"

DEPEND="virtual/perl-Scalar-List-Utils
	dev-lang/perl"
RDEPEND="${DEPEND}"
