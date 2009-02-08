# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SQL-Statement/SQL-Statement-1.19.ebuild,v 1.1 2009/02/08 09:32:37 tove Exp $

MODULE_AUTHOR=REHSACK
inherit perl-module

DESCRIPTION="Small SQL parser and engine"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	>=dev-perl/Clone-0.30
	>=dev-perl/Params-Util-0.35
	virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}"

SRC_TEST="do"
