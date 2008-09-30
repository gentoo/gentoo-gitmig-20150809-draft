# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Convert-UUlib/Convert-UUlib-1.11.ebuild,v 1.1 2008/09/30 12:13:55 tove Exp $

MODULE_AUTHOR=MLEHMANN
inherit perl-module

DESCRIPTION="A Perl interface to the uulib library"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
