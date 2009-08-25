# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CPAN-Mini-Inject/CPAN-Mini-Inject-0.26.ebuild,v 1.1 2009/08/25 17:15:32 robbat2 Exp $

EAPI=2

MODULE_AUTHOR=ANDYA
inherit perl-module

DESCRIPTION="Inject modules into a CPAN::Mini mirror. "

SLOT="0"
KEYWORDS="~ia64 ~sparc ~x86"
IUSE=""

# Disabled
#SRC_TEST="do"

RDEPEND="dev-perl/libwww-perl
	virtual/perl-IO-Compress
	virtual/perl-Archive-Tar
	>=dev-perl/CPAN-Mini-0.32
	dev-perl/CPAN-Checksums"
#	test? ( dev-perl/HTTP-Server-Simple )"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
