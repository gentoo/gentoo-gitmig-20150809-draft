# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-EN-Inflect/Lingua-EN-Inflect-1.89.1.ebuild,v 1.1 2009/11/10 10:55:40 robbat2 Exp $

MODULE_AUTHOR="DCONWAY"
# not done with versionator because it needs to be defined before perl-module is
# inherited.
MY_P="${PN}-1.891" 
S="${WORKDIR}/${MY_P}"
inherit perl-module

DESCRIPTION="Perl module for Lingua::EN::Inflect"
SRC_TEST="do"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"
