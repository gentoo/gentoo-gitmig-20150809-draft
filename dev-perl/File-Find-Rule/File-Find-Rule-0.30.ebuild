# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Find-Rule/File-Find-Rule-0.30.ebuild,v 1.14 2008/11/18 14:56:26 tove Exp $

inherit perl-module

DESCRIPTION="Alternative interface to File::Find"
SRC_URI="mirror://cpan/authors/id/R/RC/RCLAMP/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/R/RC/RCLAMP/File-Find-Rule-${PV}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

RDEPEND="virtual/perl-Test-Simple
	virtual/perl-File-Spec
	dev-perl/Number-Compare
	dev-perl/Text-Glob
	dev-lang/perl"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
