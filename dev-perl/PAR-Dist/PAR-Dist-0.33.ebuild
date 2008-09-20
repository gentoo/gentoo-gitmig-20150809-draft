# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PAR-Dist/PAR-Dist-0.33.ebuild,v 1.1 2008/09/20 07:09:10 tove Exp $

MODULE_AUTHOR=SMUELLER
inherit perl-module

DESCRIPTION="Create and manipulate PAR distributions"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl
	virtual/perl-File-Spec
	virtual/perl-File-Temp
	|| ( dev-perl/YAML-Syck dev-perl/yaml )
	dev-perl/Archive-Zip"
	# || ( YAML::Syck YAML YAML-Tiny YAML-XS Parse-CPAN-Meta )
