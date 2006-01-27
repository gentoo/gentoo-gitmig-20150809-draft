# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Find-Rule/File-Find-Rule-0.26.ebuild,v 1.14 2006/01/27 20:26:26 hansmi Exp $

inherit perl-module

DESCRIPTION="Alternative interface to File::Find"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/R/RC/RCLAMP/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha hppa ~mips ppc sparc x86"
IUSE=""

DEPEND="perl-core/Test-Simple
	perl-core/File-Spec
	dev-perl/Number-Compare
	dev-perl/Text-Glob
	dev-perl/module-build"
