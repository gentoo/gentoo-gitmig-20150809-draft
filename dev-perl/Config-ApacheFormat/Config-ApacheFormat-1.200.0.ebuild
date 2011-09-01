# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-ApacheFormat/Config-ApacheFormat-1.200.0.ebuild,v 1.1 2011/09/01 10:48:01 tove Exp $

EAPI=4

MODULE_AUTHOR=SAMTREGAR
MODULE_VERSION=1.2
inherit perl-module

DESCRIPTION="use Apache format config files"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/Class-MethodMaker
		virtual/perl-Text-Balanced
		virtual/perl-File-Spec"
DEPEND="${RDEPEND}"

SRC_TEST="do"
