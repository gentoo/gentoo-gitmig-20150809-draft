# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Pod-Coverage/Pod-Coverage-0.14.ebuild,v 1.10 2004/10/19 17:36:01 kloeri Exp $

inherit perl-module

DESCRIPTION="Checks if the documentation of a module is comprehensive"
HOMEPAGE="http://search.cpan.org/~rclamp/${P}/"
SRC_URI="mirror://cpan/authors/id/R/RC/RCLAMP/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha ~amd64"
IUSE=""
SRC_TEST="do"
style="builder"

DEPEND="dev-perl/module-build
		dev-perl/PodParser
		dev-perl/Devel-Symdump"
