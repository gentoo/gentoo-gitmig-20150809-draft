# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Pod-Coverage/Pod-Coverage-0.16.ebuild,v 1.11 2006/07/02 03:06:58 mcummings Exp $

inherit perl-module

DESCRIPTION="Checks if the documentation of a module is comprehensive"
HOMEPAGE="http://search.cpan.org/~rclamp/Pod-Coverage-0.16/"
SRC_URI="mirror://cpan/authors/id/R/RC/RCLAMP/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/module-build
		dev-perl/ExtUtils-CBuilder
		perl-core/PodParser
		dev-perl/Devel-Symdump"
