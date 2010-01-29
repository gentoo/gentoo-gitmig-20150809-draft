# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CPAN-Mini-Inject/CPAN-Mini-Inject-0.27.ebuild,v 1.1 2010/01/29 14:50:04 tove Exp $

EAPI=2

MODULE_AUTHOR=ANDYA
inherit perl-module

DESCRIPTION="Inject modules into a CPAN::Mini mirror. "

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"
IUSE=""

# Disabled
#SRC_TEST="do"

RDEPEND="dev-perl/libwww-perl
	virtual/perl-IO-Compress
	virtual/perl-Archive-Tar
	virtual/perl-File-Path
	virtual/perl-File-Temp
	virtual/perl-Module-Build
	>=dev-perl/CPAN-Mini-0.32
	dev-perl/CPAN-Checksums
	dev-perl/File-Slurp"
#	test? ( dev-perl/HTTP-Server-Simple )"
DEPEND="${RDEPEND}"
