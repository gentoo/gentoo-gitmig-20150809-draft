# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Locale-PO/Locale-PO-0.21.ebuild,v 1.4 2009/05/02 16:12:38 nixnut Exp $

MODULE_AUTHOR=KEN
inherit perl-module

DESCRIPTION="Object-oriented interface to gettext po-file entries"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE=""

DEPEND="sys-devel/gettext
	dev-perl/File-Slurp
	dev-lang/perl"

SRC_TEST="do"
