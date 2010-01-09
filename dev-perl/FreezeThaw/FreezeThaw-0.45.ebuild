# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/FreezeThaw/FreezeThaw-0.45.ebuild,v 1.2 2010/01/09 21:16:07 grobian Exp $

MODULE_AUTHOR=ILYAZ
MODULE_SECTION=modules
inherit perl-module

DESCRIPTION="converting Perl structures to strings and back"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}"

SRC_TEST=do
