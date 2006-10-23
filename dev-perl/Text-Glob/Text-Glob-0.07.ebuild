# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Glob/Text-Glob-0.07.ebuild,v 1.6 2006/10/23 18:17:15 gustavoz Exp $

inherit perl-module

DESCRIPTION="Match globbing patterns against text"
SRC_URI="mirror://cpan/authors/id/R/RC/RCLAMP/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/R/RC/RCLAMP/${P}.readme"

SRC_TEST="do"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha amd64 hppa ia64 ~mips ppc ~ppc64 sparc ~x86"
IUSE=""

DEPEND=">=dev-perl/module-build-0.28
	dev-lang/perl"
