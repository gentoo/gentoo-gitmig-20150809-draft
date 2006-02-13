# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Pod-Coverage/Pod-Coverage-0.14.ebuild,v 1.15 2006/02/13 13:55:25 mcummings Exp $

inherit perl-module

DESCRIPTION="Checks if the documentation of a module is comprehensive"
HOMEPAGE="http://search.cpan.org/~rclamp/${P}/"
SRC_URI="mirror://cpan/authors/id/R/RC/RCLAMP/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/module-build
		virtual/perl-PodParser
		dev-perl/Devel-Symdump"
