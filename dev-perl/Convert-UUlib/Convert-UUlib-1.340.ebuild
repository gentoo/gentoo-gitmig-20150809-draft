# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Convert-UUlib/Convert-UUlib-1.340.ebuild,v 1.1 2011/01/13 12:48:38 tove Exp $

EAPI=3

MODULE_AUTHOR=MLEHMANN
MODULE_VERSION=1.34
inherit perl-module

DESCRIPTION="A Perl interface to the uulib library"

LICENSE="Artistic GPL-2" # needs both
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

SRC_TEST="do"
