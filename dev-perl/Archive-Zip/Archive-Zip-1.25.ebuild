# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Zip/Archive-Zip-1.25.ebuild,v 1.1 2008/10/11 07:57:14 tove Exp $

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="A wrapper that lets you read Zip archive members as if they were files"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=">=dev-perl/Compress-Zlib-1.14
	>=virtual/perl-File-Spec-0.80
	dev-lang/perl"

SRC_TEST="do"
