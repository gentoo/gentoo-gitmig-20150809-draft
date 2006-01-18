# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Find-Rule/File-Find-Rule-0.28.ebuild,v 1.16 2006/01/18 09:03:46 gmsoft Exp $

inherit perl-module

DESCRIPTION="Alternative interface to File::Find"
SRC_URI="mirror://cpan/authors/id/R/RC/RCLAMP/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/R/RC/RCLAMP/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha ~amd64 hppa ia64 ~mips ~ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="perl-core/Test-Simple
	perl-core/File-Spec
	dev-perl/Number-Compare
	dev-perl/Text-Glob
	dev-perl/module-build"
