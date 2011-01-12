# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PGPLOT/PGPLOT-2.210.ebuild,v 1.1 2011/01/12 17:08:40 tove Exp $

EAPI=3

MODULE_AUTHOR=KGB
MODULE_VERSION=2.21
inherit perl-module

DESCRIPTION="allow subroutines in the PGPLOT graphics library to be called from Perl."

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

# Tests require active X display
#SRC_TEST="do"

RDEPEND="sci-libs/pgplot
	>=dev-perl/ExtUtils-F77-1.13"
DEPEND="${RDEPEND}"
